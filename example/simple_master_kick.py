import sys
import os
import argparse

sys.path.insert(1, '{}/qube_master/software'.format(os.getenv('HOME')))

import qubemasterclient
import sequencerclient

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    
    parser.add_argument('targets', nargs='*')
    parser.add_argument('--repetition', type=int, default=3)
    parser.add_argument('--wait', type=int, default=20)

    args = parser.parse_args()

    if len(args.targets) == 0:
        sys.exit()

    DESTINATIONS = args.targets
    REPETITION = args.repetition
    REPEAT_WAIT_SEC = args.wait
    PORT = 16384
    IPADDR = '10.3.0.255'

    repeat_wait_sec = REPEAT_WAIT_SEC * 125000000 # 125Mcycls = 1sec

    client = qubemasterclient.QuBEMasterClient(IPADDR, PORT)
    print('clear')
    r, a = client.clear_clock(value=0)
    print('kick')
    r, a = client.kick_clock_synch(DESTINATIONS)

    print('read')
    cur_time = client.read_clock(value=0)
    print('read result', cur_time, 'cycles')

    for i in range(REPETITION):
        cur_time += repeat_wait_sec
        print('run @', cur_time)
        for a in DESTINATIONS:
            client = sequencerclient.SequencerClient(a, PORT)
            r, a = client.add_sequencer(cur_time) # make registration
