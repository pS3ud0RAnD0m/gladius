# Author: p$3ud0R@nD0m

class SocketFuzzer < Weapon
  def initialize(prev_menu, title)
    # Common
    @prev_menu = prev_menu
    @title = title
    # Weapon specific
    @target = target
    @port = port
    @buffer = "z" * 10
  end

  def menu
    @target = "192.168.19.140"
    @port = 110
    pop3
  end

  def pop3
    s = TCPSocket.new(@target, @port)
    begin
      while line = s.gets
        puts line.chomp
        s.puts "USER bob"
        puts s.readpartial(1024)
        s.puts "PASS #{@buffer}"
        puts s.readpartial(1024)
        s.puts "QUIT"
        puts s.readpartial(1024)
      end
      s.close
    rescue SystemCallError => e
    end
  end
end



