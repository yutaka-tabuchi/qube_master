import sys
import os
import argparse
import socket
import struct

class QuBEMasterClient(object):

    BUFSIZE = 16384 # bytes
    MAX_RW_SIZE = 1440 # bytes
    TIMEOUT = 25 # sec

    def __init__(self, ip_addr, port):
        self.__dest_addr = (ip_addr, port)
        try:
            bind_host_address = os.environ['UDP_RW_BIND_ADDRESS']
        except KeyError:
            bind_host_address = ''
        self.__sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        self.__sock.settimeout(self.TIMEOUT)
        self.__sock.bind((bind_host_address, 0))
        print('open: {}:{}'.format(ip_addr, port))

    def send_recv(self, data):
        try:
            self.__sock.sendto(data, self.__dest_addr)
            return self.__sock.recvfrom(self.BUFSIZE)
        except socket.timeout as e:
            print('{},  Dest {}'.format(e, self.__dest_addr))
            raise
        except Exception as e:
            print(e)
            raise

    def kick_clock_synch(self, target_addrs):
        addrs = [self._conv2addr(a) for a in target_addrs]
        targets = [[a, 0x4001] for a in addrs]
        
        data = struct.pack('BB', 0x32, 0)
        data += struct.pack('HHH', 0, 0, 0)
        for addr,port in targets:
            print("kick: 0x{:0=8x}:{}".format(addr, port))
            data += struct.pack('>I', addr)
            data += struct.pack('>I', port)
        print(data)
        return self.send_recv(data)

    def clear_clock(self, value=0):
        data = struct.pack('BB', 0x34, 0)
        data += struct.pack('HHH', 0, 0, 0)
        data += struct.pack('<Q', value)
        print(data)
        return self.send_recv(data)

    def read_clock(self, value=0):
        data = struct.pack('BB', 0x30, 0)
        data += struct.pack('HHH', 0, 0, 0)
        data += struct.pack('<Q', value)
        print(data)
        ret = self.send_recv(data)
        print(ret)
        result = struct.unpack('<Q', ret[0][8:])
        return result[0]

    def _conv2addr(self, addr_str):
        addr_arry = [int(s) for s in addr_str.split(".")]
        a = 0
        for v in addr_arry:
            a = (a << 8) | v
        return a
    
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--ipaddr', default='10.3.0.255')
    parser.add_argument('--port', type=int, default='16384')
    parser.add_argument('--command', default='')
    parser.add_argument('--value', type=int, default=0)
    parser.add_argument('destinations', nargs='*')
    args = parser.parse_args()

    client = QuBEMasterClient(args.ipaddr, int(args.port))
    if args.command == 'clear':
        r, a = client.clear_clock(value=args.value)
        print(r, a)
    elif args.command == 'read':
        ret = client.read_clock(value=args.value)
        print("clock", ret)
    elif args.command == 'kick' and len(args.destinations) > 0:
        r, a = client.kick_clock_synch(args.destinations)
        print(r, a)
    else:
        parser.print_help()
        sys.exit(0)
        
