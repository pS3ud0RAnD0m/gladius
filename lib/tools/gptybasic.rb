#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.0.1

require 'pty'

class GptyBasic
  attr_accessor :cmd
  
  def shell
    begin
      i = "#{cmd}"
      puts "Running: #{cmd}"
      PTY.spawn( i ) do |stdin, stdout, pid|
        begin
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
