#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.0.1

require 'colorize'
require_relative 'tool'
require_relative 'gpty'

class IPtables < Tool
  def initialize(title)
    @title = title
    @@path = "/sbin/iptables"
    @@hosts = []
  end
  
  # List ruleset
  def list
    header
    i = Gpty.new
    i.cmd = @@path + " -L -nv"
    i.shell
    puts
    BTServices.new("Configure Back Track Services").menu
  end
end
