#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.2

#require 'fileutils'

class DirStructure
  # change dir
  Dir.chdir("/usr/share")
  
  # create structure, if it doesn't exist
  def create
    if Dir["gladius"] == []
      Dir.mkdir("gladius")
    end
    if Dir["gladius/input"] == []
      Dir.mkdir("gladius/input")
    end
    if Dir["gladius/output"] == []
      Dir.mkdir("gladius/output")
    end
    if Dir["gladius/config"] == []
      Dir.mkdir("gladius/config")
    end
    if !File.exists?("gladius/config/gladius.conf")
      FileUtils.touch("gladius/config/gladius.conf")
    end
    if !File.exists?("gladius/input/hosts.txt")
      FileUtils.touch("gladius/input/hosts.txt")
    end
  end
end
