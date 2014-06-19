#!/usr/bin/env ruby

# Author: p$3ud0R@nD0m
# See ./licenses/COPYING file for copyright information

unless ARGV.empty?
  ARGV.clear
  puts "No need for arguments."
  puts "Entering Gladius in 3 seconds ..."
  sleep(3)
end

begin
  # Ready weapons and form up
  require_relative 'lib/helpers/path'
  include Path
  Path.load
  Path.req
  include DirStructure
  DirStructure.check
  # Splash into battle
  Session.new.create
# Tactical retreat
rescue Interrupt
  GExeption.new.exit_gladius
end
