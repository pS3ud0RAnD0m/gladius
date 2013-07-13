#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.2

#require 'fileutils'

class DirStructure
  def initialize
    @@onesixtyone_dict = Constant::PROJECT_ROOT + "/helpers/onesixtyone-dict.txt"
    @@apache_usernames_txt = Constant::PROJECT_ROOT + "/helpers/apache-usernames.txt"
    @@fierce_hosts_txt = Constant::PROJECT_ROOT + "/helpers/fierce-hosts.txt"
  end

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
    if !File.exists?("gladius/input/onesixtyone-dict.txt")
      FileUtils.cp @@onesixtyone_dict, 'gladius/input/onesixtyone-dict.txt'
    end
    if !File.exists?("gladius/input/apache-usernames.txt")
      FileUtils.cp @@apache_usernames_txt, 'gladius/input/apache-usernames.txt'
    end
    if !File.exists?("gladius/input/fierce-hosts.txt")
      FileUtils.cp @@fierce_hosts_txt, 'gladius/input/fierce-hosts.txt'
    end
  end
end
