require 'socket.so'
module Commander
	class UdpSender

		def initialize(ip, cmd, port=1111)
			@ip = ip
			@cmd = cmd
			@port = port
		end

		def connect
			sock = TCPSocket.new(@ip, @port)
			sock.write @cmd
			puts sock.read(5)
			sock.close
		end
	end
end