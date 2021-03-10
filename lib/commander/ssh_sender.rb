require "net/ssh"

module Commander
	class SshSender
		def initialize(ip, cmd, user='root', password=nil)
			@ip = ip
			@cmd = cmd
			@user = user
			@password = password
		end

		def connect
			Net::SSH.start(@ip, @user, :password => @password) do |ssh|
				ssh.exec(@cmd)
			end
		end
	end
end