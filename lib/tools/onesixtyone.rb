#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.2

require_relative '../helpers/colorize'
require_relative 'tool'
require_relative 'gpty'
require_relative '../menus/snmp'

class Onesixtyone < Tool
  def initialize(title)
    @title = title
    @@path = "onesixtyone"
    @@path_dict = "/usr/share/doc/onesixtyone/dict.txt"
    @@hosts = "/usr/share/gladius/input/hosts.txt"
  end

  # Discover common community strings:
  def discover
    header
    instruct_input1
    example("ip")
    a = File.open(@@hosts, "w")
    while line = gets
      a << line
    end
    a.close
    hosts = @@hosts
    line_count = `wc -l #{hosts} |awk '{print $1}'`.to_i
    if line_count == 0
      puts "No hosts were input.".red
      SNMP.new("SNMP").menu
    end
    puts
    i = Gpty.new
    i.cmd = @@path + " -c " + @@path_dict + " -i #{hosts} -d"
    i.shell
    puts
    SNMP.new("SNMP").menu
  end
end  
