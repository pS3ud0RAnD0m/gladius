#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.0.1

require 'colorize'
require_relative 'tool'
require_relative '../shells/gpty'

class IPtables < Tool
  def initialize
    @@path = "/sbin/iptables"
    @@hosts = []
  end
  
  # List ruleset
  def list
    i = Gpty.new
    i.cmd = @@path + " -L -nv"
    i.shell
    puts
    @title = "Configure Back Track Services"
    header
    BTServices.new.menu
  end
end
