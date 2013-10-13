#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

begin
  require_relative 'lib/helpers/path'
  include Path
  # Put soldiers into formation
  Path.load
  # Ready all weapons
  Path.req
  # Splash into battle
  include Splash
  battle
# Tactical retreat
rescue Interrupt
  puts
  puts "Exiting Gladius. Have a bloody day!".red
  puts
rescue Exception => e
  puts e
end
