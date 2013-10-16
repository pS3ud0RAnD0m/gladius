#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

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
