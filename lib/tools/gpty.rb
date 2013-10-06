#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require 'pty'
require_relative 'tool'
require_relative '../helpers/colorize'

class Gpty
  attr_accessor :cmd
  attr_accessor :time

  def shell
    begin
      a = "#{time}"
      b = "#{cmd}"
      c = "/usr/share/gladius/tmp/pids/#{time}"
      puts "Running: #{cmd}".light_yellow
      PTY.spawn( b ) do |stdin, stdout, pid|
        begin
          d = File.open(c, "w") { |file| file.write("#{pid}") }
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
