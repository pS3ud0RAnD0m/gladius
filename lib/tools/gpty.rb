#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require 'pty'
require_relative '../helpers/colorize'

class Gpty
  attr_accessor :cmd
  
  def shell
    begin
      a = "#{cmd}"
      puts "Running: #{cmd}".light_yellow
      PTY.spawn( a ) do |stdin, stdout, pid|
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
