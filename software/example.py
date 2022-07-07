import sys
import argparse
import socket
import struct

import qubemasterclient 
import sequencerclient

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--ipaddr', default='10.3.0.255')
    parser.add_argument('--port', type=int, default='16384')
    parser.add_argument('--value', type=int, default=0)
    parser.add_argument('--sec', type=int, default=10)
    parser.add_argument('destinations', nargs='*')
    args = parser.parse_args()

    cycles = args.sec * 125000000 # 125Mcycls = 1sec
    addrs = [qubemasterclient.conv2addr(a) for a in args.destinations]
    targets = [[a, 0x4001] for a in addrs]

    client = qubemasterclient.QuBEMasterClient(args.ipaddr, int(args.port))
    print('clear')
    r, a = client.clear_clock(value=args.value)
    print('kick')
    r, a = client.kick_clock_synch(targets)

    print('read')
    ret = client.read_clock(value=args.value)
    print('read result', ret, 'cycles')

    print('run @', ret+cycles)
    for a in args.destinations:
        client = sequencerclient.SequencerClient(a, int(args.port))
        r, a = client.add_sequencer(ret + cycles) # make registration

    print('run @', ret+cycles+60*125000000)
    for a in args.destinations:
        client = sequencerclient.SequencerClient(a, int(args.port))
        r, a = client.add_sequencer(ret + cycles + 10*125000000) # make registration

