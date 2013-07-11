#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.2

require 'sqlite3'
require 'fileutils'
require_relative 'lib/menus/splash'
require_relative 'lib/menus/home'
require_relative 'lib/helpers/colorize'
require_relative 'lib/helpers/constant'
#require_relative 'lib/tools/environment'

# Splash and (check reqs) go to home menu
begin
Splash.new.ascii
#Environment.new.requirements
Home.new("Home                   v0.0.2").menu
rescue Interrupt
  puts
  puts "Exiting Gladius. Have a bloody day!".red
rescue Exception => e
  puts e
end
