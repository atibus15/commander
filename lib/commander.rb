require "commander/version"
require "commander/tcp_sender"
require "commander/udp_sender"
require "commander/ssh_sender"


module Commander
  def self.deliver(ip, command,  port=1111, type='tcp')
		@ip = ip
		@command = command
		@type = type
		@port = port
		return connection.connect
	end

	private

		def self.connection
			return case @type
			when 'tcp'
				TcpSender.new(@ip, @command, @port, 1)
			when 'udp'
				UdpSender.new(@ip, @command, @port)
			when 'ssh'
				SshSender.new(@ip, @command, @port)
			end
		end
end
