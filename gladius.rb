#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

begin
  require_relative 'lib/helpers/path'
  include Path
  
  # Add directories to the load path
  Path.load
  
  # Add all requires
  Path.req
  
  # Check for dir structure, add what's needed
  include DirStructure
  DirStructure.create
  
  # Splash
  include Splash
  ascii
rescue Interrupt
  puts
  puts "Exiting Gladius. Have a bloody day!".red
  puts
rescue Exception => e
  puts e
end
