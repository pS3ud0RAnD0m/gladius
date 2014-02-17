# Author: p$3ud0R@nD0m

class Gpty
  attr_accessor :cmd
  attr_accessor :pid_file

  def shell
    begin
      a = "#{pid_file}"
      b = "#{cmd}"
      puts "Running: #{cmd}".light_yellow
      PTY.spawn( b ) do |stdin, stdout, pid|
        begin
          File.open(a, "w") { |file| file.write("#{pid}") }
          stdin.each { |line| print line }
        rescue Errno::EIO
# ttd_2: Exit needs resolved.
        end
      end
    rescue PTY::ChildExited
      puts "The child process exited!"
    end
  end
end
