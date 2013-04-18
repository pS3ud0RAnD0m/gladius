#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.1

require_relative 'lib/tools/environment'
require_relative 'lib/menus/home'

# Splash and check reqs
begin
Home.new("").splash
Environment.new.requirements
rescue Interrupt
  puts "\nExiting Gladius. Have a bloody day!".red
rescue Exception => e
  puts e
end
