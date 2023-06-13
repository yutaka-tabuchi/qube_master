import sys
import argparse
import socket
import struct
import time

class QuBEMonitor(object):
    BUFSIZE = 16384
    TIMEOUT = 25

    def __init__(self, ip_addr, port):
        self.__dest_addr = (ip_addr, port)
        self.__sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        self.__sock.settimeout(self.TIMEOUT)
        self.__sock.bind(('', 0))
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

    def read_time(self):
        data = struct.pack('BBBB', 0x00, 0x00, 0x00, 0x04)
        ret,addr = self.send_recv(data)
        return struct.unpack('>Q', ret[4:12])[0]

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--ipaddr', default='10.2.0.255')
    parser.add_argument('--port', type=int, default='16385')
    args = parser.parse_args()

    q = QuBEMonitor(args.ipaddr, int(args.port))

    for i in range(5):
        v = q.read_time()
        print("counter={}, time={}".format(v, v/(125*1000*1000)))
        time.sleep(1)

    v = q.read_time()
    print("counter={}, time={}".format(v, v/(125*1000*1000)))
