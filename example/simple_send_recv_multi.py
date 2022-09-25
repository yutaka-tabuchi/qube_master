import sys
import os
import pathlib
import math
import argparse
import datetime
import numpy as np
import matplotlib.pyplot as plt
from concurrent.futures import ThreadPoolExecutor

sys.path.insert(1, '{}/e7awg_sw/'.format(os.getenv('HOME')))
from e7awgsw import CaptureModule, AWG, AwgCtrl, CaptureCtrl, WaveSequence, CaptureParam, plot_graph

def set_trigger_awg(cap_ctrl, awg, capture_modules):
    for cap_mod_id in capture_modules:
        cap_ctrl.select_trigger_awg(cap_mod_id, awg)
        cap_ctrl.enable_start_trigger(*CaptureModule.get_units(cap_mod_id))


def gen_cos_wave(freq, num_cycles, amp):
    """
    freq : MHz
    """
    dt = 2.0 * math.pi * (freq * 1e6) / AwgCtrl.SAMPLING_RATE
    num_samples = int(num_cycles * AwgCtrl.SAMPLING_RATE / (freq * 1e6))
    i_data =  [int(amp * math.cos(i * dt)) for i in range(num_samples)]
    q_data =  [int(amp * math.sin(i * dt)) for i in range(num_samples)]
    return list(zip(i_data, q_data))


def gen_wave_seq(num_wait_words=16, amp=5000):
    wave_seq = WaveSequence(
        num_wait_words = num_wait_words,
        num_repeats = 1)
    
    num_chunks = 1
    for i in range(num_chunks):
        samples = gen_cos_wave(2.5, 8, amp)
        print('samples:', len(samples))
        # 1 波形チャンクのサンプル数は 64 の倍数でなければならない
        num_samples_in_wblcok = WaveSequence.NUM_SAMPLES_IN_WAVE_BLOCK
        if len(samples) % num_samples_in_wblcok != 0:
            additional_samples = num_samples_in_wblcok - (len(samples) % num_samples_in_wblcok)
            samples.extend([(0, 0)] * additional_samples)
        wave_seq.add_chunk(
            iq_samples = samples, # 50MHz cos x2
            num_blank_words = 0, 
            num_repeats = 1)
    return wave_seq


def set_wave_sequence(awg_ctrl, awgs, num_wait_words=16, amp=5000):
    awg_to_wave_sequence = {}
    wave_seq = gen_wave_seq(num_wait_words, amp)
    for awg_id in awgs:
        awg_to_wave_sequence[awg_id] = wave_seq
        awg_ctrl.set_wave_sequence(awg_id, wave_seq)
    return awg_to_wave_sequence


def set_capture_params(cap_ctrl, wave_seq, capture_units):
    capture_param = gen_capture_param(wave_seq)
    for captu_unit_id in capture_units:
        cap_ctrl.set_capture_params(captu_unit_id, capture_param)


def gen_capture_param(wave_seq):
    capture_param = CaptureParam()
    capture_param.num_integ_sections = 1
    capture_param.add_sum_section(20*(wave_seq.num_all_words - wave_seq.num_wait_words), 1) # 総和区間を 1 つだけ定義する
    print("capture_len", 20*(wave_seq.num_all_words - wave_seq.num_wait_words))
    capture_param.capture_delay = CAPTURE_DELAY
    return capture_param


def get_capture_data(cap_ctrl, capture_units):
    capture_unit_to_capture_data = {}
    for capture_unit_id in capture_units:
        num_captured_samples = cap_ctrl.num_captured_samples(capture_unit_id)
        capture_unit_to_capture_data[capture_unit_id] = cap_ctrl.get_capture_data(capture_unit_id, num_captured_samples)
    return capture_unit_to_capture_data


def save_wave_data(prefix, sampling_rate, id_to_samples, save_dir='.'):
    for id, samples in id_to_samples.items():
        dir = save_dir + '/{}_{}'.format(prefix, id)
        os.makedirs(dir, exist_ok = True)
        print('save {} {} data'.format(prefix, id))

        # I/Q データテキストファイル保存
        filepath = dir + '/{}_{}.txt'.format(prefix, id)
        with open(filepath, 'w') as txt_file:
            for i_data, q_data in samples:
                txt_file.write("{}  ,  {}\n".format(i_data, q_data))

        # I データグラフ保存
        i_data = [sample[0] for sample in samples]
        plot_graph(
            sampling_rate, 
            i_data, 
            '{}_{}_I'.format(prefix, id), 
            dir + '/{}_{}_I.png'.format(prefix, id),
            '#b44c97')

        # Q データグラフ保存
        q_data = [sample[1] for sample in samples]
        plot_graph(
            sampling_rate,
            q_data, 
            '{}_{}_Q'.format(prefix, id), 
            dir + '/{}_{}_Q.png'.format(prefix, id),
            '#00a497')


def check_err(awg_ctrl, cap_ctrl, awgs, capture_units):
    awg_to_err = awg_ctrl.check_err(*awgs)
    for awg_id, err_list in awg_to_err.items():
        print(awg_id)
        for err in err_list:
            print('    {}'.format(err))
    
    cap_unit_to_err = cap_ctrl.check_err(*capture_units)
    for cap_unit_id, err_list in cap_unit_to_err.items():
        print('{} err'.format(cap_unit_id))
        for err in err_list:
            print('    {}'.format(err))


def create_awg_ctrl(use_labrad, server_ip_addr, ip_addr):
    if use_labrad:
        return RemoteAwgCtrl(server_ip_addr, ip_addr)
    else:
        return AwgCtrl(ip_addr)


def create_capture_ctrl(use_labrad, server_ip_addr, ip_addr):
    if use_labrad:
        return RemoteCaptureCtrl(server_ip_addr, ip_addr)
    else:
        return CaptureCtrl(ip_addr)


def main(awgs, capture_modules, ip_addr, use_labrad, server_ip_addr, num_wait_words, save_dir='.', timeout=5, use_sequencer=False, save_data=False, amp=5000, repetition=2):
    with (create_awg_ctrl(use_labrad, server_ip_addr, ip_addr) as awg_ctrl,
          create_capture_ctrl(use_labrad, server_ip_addr, ip_addr) as cap_ctrl):
        capture_units = CaptureModule.get_units(*capture_modules)
        # 初期化
        awg_ctrl.initialize(*awgs)
        cap_ctrl.initialize(*capture_units)
        # トリガ AWG の設定
        set_trigger_awg(cap_ctrl, awgs[0], capture_modules)
        # 波形シーケンスの設定
        awg_to_wave_sequence = set_wave_sequence(awg_ctrl, awgs, num_wait_words, amp)
        # キャプチャパラメータの設定
        set_capture_params(cap_ctrl, awg_to_wave_sequence[awgs[0]], capture_units)

        capture_unit_to_capture_data_list = []
        for i in range(repetition):
            awg_ctrl.clear_awg_stop_flags(*awgs)
            print("wait:", datetime.datetime.now())
            if use_sequencer == False:
                # 波形送信スタート
                awg_ctrl.start_awgs(*awgs)
            else:
                print("wait for started by sequencer for {}".format(ip_addr))
            # 波形送信完了待ち
            awg_ctrl.wait_for_awgs_to_stop(timeout, *awgs)
            print("awg done:", datetime.datetime.now())
            # キャプチャ完了待ち
            cap_ctrl.wait_for_capture_units_to_stop(timeout, *capture_units)
            # エラーチェック
            check_err(awg_ctrl, cap_ctrl, awgs, capture_units)
            # キャプチャデータ取得
            capture_unit_to_capture_data = get_capture_data(cap_ctrl, capture_units)
            # 波形保存
            if save_data:
                awg_to_wave_data = {awg: wave_seq.all_samples(False) for awg, wave_seq in awg_to_wave_sequence.items()}
                save_wave_data('awg', AwgCtrl.SAMPLING_RATE, awg_to_wave_data, save_dir)
                save_wave_data('capture', CaptureCtrl.SAMPLING_RATE, capture_unit_to_capture_data, save_dir)
            print('end')
            capture_unit_to_capture_data_list.append(capture_unit_to_capture_data)

        return capture_unit_to_capture_data_list
        
if __name__ == "__main__":
    parser = argparse.ArgumentParser()

    parser.add_argument('targets', nargs='*')
    parser.add_argument('--delay', type=int, default=0) 
    parser.add_argument('--dir', default='result_send_recv/') 
    parser.add_argument('--timeout', type=int, default=40) 
    parser.add_argument('--repetition', type=int, default=3) 

    args = parser.parse_args()

    if len(args.targets) == 0:
        sys.exit()

    TARGET_QUBE = args.targets
    CAPTURE_DELAY = args.delay
    SAVE_DIR = args.dir
    TIME_OUT = args.timeout
    REPETITION = args.repetition

    os.makedirs(SAVE_DIR, exist_ok = True)

    awgs = AWG.all()
    capture_modules = CaptureModule.all()

    threads = []
    num_wait_values = [0, 500]
    amps = [5000,3000]
    rets = []

    with ThreadPoolExecutor() as e:
        for i,qube in enumerate(TARGET_QUBE):
            thread = e.submit(
                lambda: main(awgs, capture_modules, qube, False, 'localhost', num_wait_values[i], SAVE_DIR, TIME_OUT, True, False, amps[i], REPETITION))
            threads.append(thread)
            print("Thread start #{}".format(i))
        rets = [thread.result() for thread in threads]

    ret = rets[0]

    for i in [0]:
        print('Capture #{} (I)'.format(i))
        s = slice(0,-1)
        a = np.array(ret[0][i])
        time = np.linspace(0, 1e+6 * a.shape[0] / CaptureCtrl.SAMPLING_RATE, a.shape[0], endpoint=False)
        plt.plot(time[s], a[s,0])
        plt.savefig("{}/capture_{}_i.png".format(SAVE_DIR, i))
        plt.close()

    for i in [0]:
        print('Capture #{} (Q)'.format(i))
        s = slice(0,-1)
        a = np.array(ret[0][i])
        time = np.linspace(0, 1e+6 * a.shape[0] / CaptureCtrl.SAMPLING_RATE, a.shape[0], endpoint=False)
        plt.plot(time[s], a[s,1])
        plt.savefig("{}/capture_{}_q.png".format(SAVE_DIR, i))
        plt.close()

    for i in [0]:
        print('Capture #{} (I)'.format(i))
        for j in range(REPETITION):
            s = slice(0,-1)
            a = np.array(ret[j][i])
            time = np.linspace(0, 1e+6 * a.shape[0] / CaptureCtrl.SAMPLING_RATE, a.shape[0], endpoint=False)
            plt.plot(time[s], a[s,0], label=str(j))
        plt.xlim([4,6])
        plt.savefig("{}/capture_{}_i_zoom.png".format(SAVE_DIR, i))
        plt.close()

    for i in [0]:
        print('Capture #{} (Q)'.format(i))
        for j in range(REPETITION):
            s = slice(0,-1)
            a = np.array(ret[j][i])
            time = np.linspace(0, 1e+6 * a.shape[0] / CaptureCtrl.SAMPLING_RATE, a.shape[0], endpoint=False)
            plt.plot(time[s], a[s,1], label=str(j))
        plt.xlim([4,6])
        plt.savefig("{}/capture_{}_q_zoom.png".format(SAVE_DIR, i))
        plt.close()
    
    for i in [0]:
        for j in range(REPETITION):
            print("{}: @{} = {}".format(j, i, ret[j][i][300]))
