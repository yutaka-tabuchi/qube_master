import sys
import argparse
import socket
import struct

class QuBEMasterClient(object):

    BUFSIZE = 16384 # bytes
    MAX_RW_SIZE = 1440 # bytes
    TIMEOUT = 25 # sec

    def __init__(self, ip_addr, port):
        self.__dest_addr = (ip_addr, port)
        self.__sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        self.__sock.settimeout(self.TIMEOUT)
        self.__sock.bind(('', 0))
        print('open: {}:{}'.format(ip_addr, port))

    def send_recv(self, addr, data):
        try:
            self.__sock.sendto(data, self.__dest_addr)
            return self.__sock.recvfrom(self.BUFSIZE)
        except socket.timeout as e:
            print('{},  Dest {}'.format(e, self.__dest_addr))
            raise
        except Exception as e:
            print(e)
            raise

    def kick_clock_synch(self, addr, targets):
        data = struct.pack('BB', 0x32, 0)
        data += struct.pack('HHH', 0, 0, 0)
        for t in targets:
            data += struct.pack('>I', t)
        print(data)
        return self.send_recv(addr, data)

    def clear_clock(self, addr, value=0):
        data = struct.pack('BB', 0x34, 0)
        data += struct.pack('HHH', 0, 0, 0)
        data += struct.pack('<Q', value)
        print(data)
        return self.send_recv(addr, data)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--ipaddr', default='10.3.0.255')
    parser.add_argument('--port', type=int, default='16384')
    parser.add_argument('--command', default='')
    args = parser.parse_args()

    client = QuBEMasterClient(args.ipaddr, int(args.port))
    if args.command == 'clear':
        r, a = client.clear_clock('127.0.0.1', value=0x0123456789abcdef)
        print(r, a)
    elif args.command == 'kick':
        r, a = client.kick_clock_synch('127.0.0.1', [0x0a020014])
    else:
        parser.print_help()
        sys.exit(0)
        
