require "test_helper"

class CommanderTest < Minitest::Test
  def test_tcp_sender_error
    assert_equal 'error', Commander.deliver('192.168.1.10', 'maintenance', '1111')
  end

  # def test_udp_sender_error
  #   assert_equal 'error', Commander.deliver('192.168.1.10', 'maintenance', '1111', 'udp')
  # end

  # def test_ssh_sender_error
  #   assert_equal 'error', Commander.deliver('192.168.1.10', 'maintenance', '1111', 'ssh')
  # end
end
