module Commander  
  class TcpSender
		def initialize(ip, cmd, port=1111, timeout=1)
			@ip = ip
			@cmd = cmd
			@port = port
			@timeout = timeout
		end

		def connect
      response = nil
      # Convert the passed ip into structures the non-blocking calls
      # can deal with
      begin 
        addr = Socket.getaddrinfo(@ip, nil)
        sockaddr = Socket.pack_sockaddr_in(@port, addr[0][3])

        Socket.new(Socket.const_get(addr[0][0]), Socket::SOCK_STREAM, 0).tap do |socket|
          socket.setsockopt(Socket::IPPROTO_TCP, Socket::TCP_NODELAY, 1)

          begin
          # Initiate the socket connection in the background. If it doesn't fail
          # immediatelyit will raise an IO::WaitWritable (Errno::EINPROGRESS)
          # indicating the connection is in progress.
            socket.connect_nonblock(sockaddr)

          rescue IO::WaitWritable
          # IO.select will block until the socket is writable or the timeout
          # is exceeded - whichever comes first.
            if IO.select(nil, [socket], nil, @timeout)
              begin
              # Verify there is now a good connection
                socket.connect_nonblock(sockaddr)

                #Rails.logger.info "Client Request: #{@cmd}"
                socket.write(@cmd)

                response = socket.read(1000)

              rescue Errno::EISCONN
                # Good news everybody, the socket is connected!
              rescue
                # An unexpected exception was raised - the connection is no good.
                socket.close
                response = 'error'
              end
            else
              # IO.select returns nil when the socket is not ready before timeout
              # seconds have elapsed
              socket.close
              response = 'error'
            end
          end
        end
      rescue
        response = 'error'
      end

      return response
		end
	end
end