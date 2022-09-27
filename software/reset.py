#!/usr/bin/env python3
# coding: utf-8

import socket
import sys
import argparse
import socket
import struct

if __name__ == "__main__":
  parser = argparse.ArgumentParser()
  parser.add_argument('--ipaddr', default='10.3.0.255')
  parser.add_argument('--port', type=int, default='16385')
  
  args = parser.parse_args()
  client_address = (args.ipaddr, args.port)
  sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

  message = "dummy message"
  send_len = sock.sendto(message.encode('utf-8'), client_address)
  recv_meesage, addr = sock.recvfrom(2048)
  print("[Reset]: {}".format(recv_meesage.decode(encoding='utf-8')))
  sock.close()
