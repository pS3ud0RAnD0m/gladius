#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.2

require 'fileutils'

module Dirstructure
  # change dir
  Dir.chdir("/usr/share")
  
  def create
    # create structure, if it doesn't exist
    if Dir["gladius"] == []
      puts "Creating gladius dir ..."
      Dir.mkdir("gladius")
      Dir.mkdir("gladius/input")
      Dir.mkdir("gladius/output")
      Dir.mkdir("gladius/config")
      FileUtils.touch("gladius/config/gladius.conf")
      FileUtils.touch("gladius/input/hosts.txt")
      puts
    else
      puts
    end
  end

end

include Dirstructure
create
