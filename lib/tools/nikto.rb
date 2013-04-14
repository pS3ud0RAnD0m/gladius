#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.0.1

require 'colorize'
require_relative 'tool'
require_relative '../shells/gpty'

class Nikto < Tool
  def initialize(title)
    @title = title
    @@path_tool = "/pentest/web/nikto/nikto.pl"
    @@hosts = []
  end
  
  # Identify common vulns
  def common
    header
    get_port
  end
end
