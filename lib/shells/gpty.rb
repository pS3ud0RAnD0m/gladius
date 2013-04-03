#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.0.1

require 'pty'
require 'colorize'

class Gpty
  attr_accessor :cmd
  
  def shell
    begin
      i = "#{cmd}"
      puts "Running: #{cmd}".yellow
      PTY.spawn( i ) do |stdin, stdout, pid|
        begin
          # Do stuff with the output here. Just printing to show it works
          stdin.each { |line| print line }
        rescue Errno::EIO
          puts "Exit needs resolved........".red
        end
      end
    rescue PTY::ChildExited
      puts "The child process exited!"
    end
  end  
end
