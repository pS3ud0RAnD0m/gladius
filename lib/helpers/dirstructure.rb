#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

module DirStructure
  # create structure, if it doesn't exist
  def check
    # variables
    onesixtyone_dict = source + "onesixtyone-dict.txt"
    apache_usernames = source + "apache-usernames.txt"
    fierce_hosts = source + "fierce-hosts.txt"
    hydra_ftp_usrs = source + "hydra_ftp_usrs.txt"
    hydra_ftp_pwds = source + "hydra_ftp_pwds.txt"
    hydra_mysql_usrs = source + "hydra_mysql_usrs.txt"
    hydra_mysql_pwds = source + "hydra_mysql_pwds.txt"
    hydra_ssh_usrs = source + "hydra_ssh_usrs.txt"
    hydra_ssh_pwds = source + "hydra_ssh_pwds.txt"

    # Create dirs
    # See Path for variable details
    if Dir[usr_g] == []
      Dir.mkdir(usr_g)
    end
    if Dir[usr_i] == []
      Dir.mkdir(usr_i)
    end
    if Dir[usr_o] == []
      Dir.mkdir(usr_o)
    end
    if Dir[usr_c] == []
      Dir.mkdir(usr_c)
    end
    if Dir[usr_c_sess] == []
      Dir.mkdir(usr_c_sess)
    end
    if Dir[usr_c_sess_unnamed] == []
      Dir.mkdir(usr_c_sess_unnamed)
    end
    if Dir[usr_c_sess_named] == []
      Dir.mkdir(usr_c_sess_named)
    end
    if Dir[usr_t] == []
      Dir.mkdir(usr_t)
    end
    if Dir[usr_tp] == []
      Dir.mkdir(usr_tp)
    end
    # Create input files
    Dir.chdir(usr_i)
    if !File.exists?("stdn_hosts.txt")
      FileUtils.touch("stdn_hosts.txt")
    end
    if !File.exists?("stdn_usrs.txt")
      FileUtils.touch("stdn_usrs.txt")
    end
    if !File.exists?("stdn_pwds.txt")
      FileUtils.touch("stdn_pwds.txt")
    end
    if !File.exists?("onesixtyone-dict.txt")
      FileUtils.cp onesixtyone_dict, 'onesixtyone_dict.txt'
    end
    if !File.exists?("apache-usernames.txt")
      FileUtils.cp apache_usernames, 'apache_usernames.txt'
    end
    if !File.exists?("fierce-hosts.txt")
      FileUtils.cp fierce_hosts, 'fierce_hosts.txt'
    end
    if !File.exists?("hydra_ftp_usrs.txt")
      FileUtils.cp hydra_ftp_usrs, 'hydra_ftp_usrs.txt'
    end
    if !File.exists?("hydra_ftp_pwds.txt")
      FileUtils.cp hydra_ftp_pwds, 'hydra_ftp_pwds.txt'
    end
    if !File.exists?("hydra_mysql_usrs.txt")
      FileUtils.cp hydra_mysql_usrs, 'hydra_mysql_usrs.txt'
    end
    if !File.exists?("hydra_mysql_pwds.txt")
      FileUtils.cp hydra_mysql_pwds, 'hydra_mysql_pwds.txt'
    end
    if !File.exists?("hydra_ssh_usrs.txt")
      FileUtils.cp hydra_ssh_usrs, 'hydra_ssh_usrs.txt'
    end
    if !File.exists?("hydra_ssh_pwds.txt")
      FileUtils.cp hydra_ssh_pwds, 'hydra_ssh_pwds.txt'  
    end
    # Create config file
    Dir.chdir(usr_c)
    if !File.exists?("gladius.conf")
      FileUtils.touch("gladius.conf")
    end
  end
end
