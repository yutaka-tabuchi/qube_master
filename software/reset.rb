#!/usr/bin/env ruby

require "socket"
socket = UDPSocket.open()
sockaddr = Socket.pack_sockaddr_in(0x4001, "10.3.0.255")
socket.send("Hello World", 0, sockaddr)
socket.close
