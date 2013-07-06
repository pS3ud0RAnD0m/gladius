#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.2

#require_relative 'lib/tools/environment'
require 'sqlite3'
require_relative 'lib/menus/splash'
require_relative 'lib/menus/home'
require_relative 'lib/helpers/colorize'

# Splash and (check reqs) go to home menu
begin
Splash.new.ascii
#Environment.new.requirements
Home.new("Home                   v0.0.2").menu
rescue Interrupt
  puts "\nExiting Gladius. Have a bloody day!".red
rescue Exception => e
  puts e
end
