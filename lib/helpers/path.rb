#!/usr/bin/env ruby

# Author: p$3ud0R@nD0m

module Path
  def lib_root
    root = File.expand_path("..", File.dirname(__FILE__))
  end

  def load
    $:.push lib_root + "/menus"
    $:.push lib_root + "/tools"
    $:.push lib_root + "/helpers"
    $:.push lib_root + "/helpers/parsers"
  end
  
  def req
    Dir[lib_root + "/menus/*.rb"].each { |a| require a }
    Dir[lib_root + "/tools/*.rb"].each { |a| require a }
    Dir[lib_root + "/helpers/*.rb"].each { |a| require a }
    Dir[lib_root + "/helpers/parsers/*.rb"].each { |a| require a }
    require 'fileutils'
    require 'pty'
    require 'time'

  end

# ttd: square get_path and replace all path methods (look at gpty)
  def get_path(my_alias)
    #case my_alias
    #  when "hosts_file" then puts "/usr/share/gladius/input/stdn_hosts.txt"
    #  when "hosts_file" then a = "/usr/share/gladius/input/stdn_hosts.txt"
    #  when "hosts_file" then hosts_file
    #end
  end

# ttd: ensure that your paths are dry here
# ttd: scale path names, e.g., "mysql_usrs_long.txt"
  def ftp_pwds
    a = "/usr/share/gladius/input/hydra_ftp_pwds.txt"
  end

  def ftp_usrs
    a = "/usr/share/gladius/input/hydra_ftp_usrs.txt"
  end

  def mysql_pwds
    a = "/usr/share/gladius/input/hydra_mysql_pwds.txt"
  end

  def mysql_usrs
    a = "/usr/share/gladius/input/hydra_mysql_usrs.txt"
  end

  def snmp_comm_strings_long
    a = "/usr/share/gladius/input/onesixtyone_dict.txt"
    a = "/usr/share/gladius/input/snmp_comm_strings_long.txt"
  end
  
  def ssh_pwds
    a = "/usr/share/gladius/input/hydra_ssh_pwds.txt"
  end

  def ssh_usrs
    a = "/usr/share/gladius/input/hydra_ssh_usrs.txt"
  end

  def stdn_pwds
    a = "/usr/share/gladius/input/stdn_pwds.txt"
  end

  def stdn_usrs
    a = "/usr/share/gladius/input/stdn_usrs.txt"
  end

  def hosts_file
    a = "/usr/share/gladius/input/stdn_hosts.txt"
  end

  def usr
    a = "/usr/share"
  end
  
  def usr_g
    usr = "/usr/share/gladius"
  end
  
  def usr_i
    a = "/usr/share/gladius/input"
  end
  
  def usr_o
    a = "/usr/share/gladius/output"
  end
  
  def usr_c
    a = "/usr/share/gladius/config"
  end

  def usr_c_sess
    a = "/usr/share/gladius/config/sessions"
  end

  def usr_c_sess_unnamed
    a = "/usr/share/gladius/config/sessions/unnamed"
  end
  
  def usr_c_sess_named
    a = "/usr/share/gladius/config/sessions/named"
  end

  def usr_t
    a = "/usr/share/gladius/tmp"
  end
  
# ttd: see how trailing slash effect dirstructure creation.
  def usr_tp
    a = "/usr/share/gladius/tmp/pids/"
  end
  
  def source
    a = lib_root + "/helpers/input/"
  end

  def get_out_file(tool)
    time = Time.now
    out_file = time.strftime("/usr/share/gladius/output/" + tool + "_%F_%H-%M-%S")
  end
  
  def get_out_file_txt(tool)
    time = Time.now
    out_file = time.strftime("/usr/share/gladius/output/" + tool + "_%F_%H-%M-%S.txt")
  end

  def get_pid_file
    time = Time.now
    pid_tstamp = "%10.10f" % time.to_f
    pid_file = time.strftime(usr_tp + pid_tstamp + ".pid")
  end
end
