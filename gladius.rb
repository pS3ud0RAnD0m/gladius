#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.2

#require 'sqlite3'
require 'fileutils'
require_relative 'lib/menus/splash'
require_relative 'lib/menus/home'
require_relative 'lib/helpers/colorize'
require_relative 'lib/helpers/constant'
require_relative 'lib/helpers/dirstructure'

begin
# Check for dir structure, add what's needed
DirStructure.new.create

# Splash and go to home menu
Splash.new.ascii
Home.new("Home                   v0.0.2").menu

# Catch errors
rescue Interrupt
  puts
  puts "Exiting Gladius. Have a bloody day!".red
rescue Exception => e
  puts e
end
