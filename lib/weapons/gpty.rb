#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

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
          c = File.open(a, "w") { |file| file.write("#{pid}") }
          stdin.each { |line| print line }
        rescue Errno::EIO
          #puts "Exit needs resolved........".red
        end
      end
    rescue PTY::ChildExited
      puts "The child process exited!"
    end
  end  
end
