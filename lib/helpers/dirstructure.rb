#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

module DirStructure
  def initialize
    @@onesixtyone_dict = Constant::PROJECT_ROOT + "/helpers/input/onesixtyone-dict.txt"
    @@apache_usernames = Constant::PROJECT_ROOT + "/helpers/input/apache-usernames.txt"
    @@fierce_hosts = Constant::PROJECT_ROOT + "/helpers/input/fierce-hosts.txt"
    @@hydra_ftp_usrs = Constant::PROJECT_ROOT + "/helpers/input/hydra_ftp_usrs.txt"
    @@hydra_ftp_pwds = Constant::PROJECT_ROOT + "/helpers/input/hydra_ftp_pwds.txt"
    @@hydra_mysql_usrs = Constant::PROJECT_ROOT + "/helpers/input/hydra_mysql_usrs.txt"
    @@hydra_mysql_pwds = Constant::PROJECT_ROOT + "/helpers/input/hydra_mysql_pwds.txt"
    @@hydra_ssh_usrs = Constant::PROJECT_ROOT + "/helpers/input/hydra_ssh_usrs.txt"
    @@hydra_ssh_pwds = Constant::PROJECT_ROOT + "/helpers/input/hydra_ssh_pwds.txt"
  end

  # create structure, if it doesn't exist
  def create
    Dir.chdir("/usr/share")
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
    if Dir["gladius/tmp"] == []
      Dir.mkdir("gladius/tmp")
    end
    if Dir["gladius/tmp/pids"] == []
      Dir.mkdir("gladius/tmp/pids")
    end
    if !File.exists?("gladius/config/gladius.conf")
      FileUtils.touch("gladius/config/gladius.conf")
    end
    if !File.exists?("gladius/input/stdn_hosts.txt")
      FileUtils.touch("gladius/input/stdn_hosts.txt")
    end
    if !File.exists?("gladius/input/stdn_usrs.txt")
      FileUtils.touch("gladius/input/stdn_usrs.txt")
    end
    if !File.exists?("gladius/input/stdn_pwds.txt")
      FileUtils.touch("gladius/input/stdn_pwds.txt")
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
    if !File.exists?("gladius/input/hydra_ftp_usrs.txt")
      FileUtils.cp @@hydra_ftp_usrs, 'gladius/input/hydra_ftp_usrs.txt'
    end
    if !File.exists?("gladius/input/hydra_ftp_pwds.txt")
      FileUtils.cp @@hydra_ftp_pwds, 'gladius/input/hydra_ftp_pwds.txt'
    end
    if !File.exists?("gladius/input/hydra_mysql_usrs.txt")
      FileUtils.cp @@hydra_mysql_usrs, 'gladius/input/hydra_mysql_usrs.txt'
    end
    if !File.exists?("gladius/input/hydra_mysql_pwds.txt")
      FileUtils.cp @@hydra_mysql_pwds, 'gladius/input/hydra_mysql_pwds.txt'
    end
    if !File.exists?("gladius/input/hydra_ssh_usrs.txt")
      FileUtils.cp @@hydra_ssh_usrs, 'gladius/input/hydra_ssh_usrs.txt'
    end
    if !File.exists?("gladius/input/hydra_ssh_pwds.txt")
      FileUtils.cp @@hydra_ssh_pwds, 'gladius/input/hydra_ssh_pwds.txt'
    end
  end
end
