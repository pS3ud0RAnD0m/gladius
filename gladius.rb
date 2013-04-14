#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.0.1

require 'colorize'
require_relative 'lib/menus/home'

#String.color_matrix( "FOO" )

begin
  a = Home.new("Home                    v0.0.1")
  a.splash
  a.menu
rescue Interrupt
  puts "\nExiting Gladius. Have a bloody day!".red
rescue Exception => e
  puts e
end
