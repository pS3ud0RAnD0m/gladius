#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

#require 'fileutils'

class DirStructure
  def initialize
    @@onesixtyone_dict = Constant::PROJECT_ROOT + "/helpers/input/onesixtyone-dict.txt"
    @@apache_usernames = Constant::PROJECT_ROOT + "/helpers/input/apache-usernames.txt"
    @@fierce_hosts = Constant::PROJECT_ROOT + "/helpers/input/fierce-hosts.txt"
    @@medusa_ssh_users = Constant::PROJECT_ROOT + "/helpers/input/medusa_ssh_users.txt"
    @@medusa_ssh_passwords = Constant::PROJECT_ROOT + "/helpers/input/medusa_ssh_passwords.txt"
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
      FileUtils.cp @@apache_usernames, 'gladius/input/apache-usernames.txt'
    end
    if !File.exists?("gladius/input/fierce-hosts.txt")
      FileUtils.cp @@fierce_hosts, 'gladius/input/fierce-hosts.txt'
    end
    if !File.exists?("gladius/input/fierce-hosts.txt")
      FileUtils.cp @@medusa_ssh_users, 'gladius/input/medusa_ssh_users.txt'
    end
    if !File.exists?("gladius/input/fierce-hosts.txt")
      FileUtils.cp @@medusa_ssh_passwords, 'gladius/input/medusa_ssh_passwords.txt'
    end
  end
end
