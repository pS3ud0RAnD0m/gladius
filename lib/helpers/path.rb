#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

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
  end
  
  def usr
    usr = "/usr/share"
  end
  
  def usr_g
    usr = "/usr/share/gladius"
  end
  
  def usr_i
    usr = "/usr/share/gladius/input"
  end
  
  def usr_o
    usr = "/usr/share/gladius/output"
  end
  
  def usr_c
    usr = "/usr/share/gladius/config"
  end

  def usr_c_sess
    usr = "/usr/share/gladius/config/sessions"
  end

  def usr_c_sess_unnamed
    usr = "/usr/share/gladius/config/sessions/unnamed"
  end
  
  def usr_c_sess_named
    usr = "/usr/share/gladius/config/sessions/named"
  end

  def usr_t
    usr = "/usr/share/gladius/tmp"
  end
  
  def usr_tp
    usr = "/usr/share/gladius/tmp/pids"
  end
  
  def source
    a = lib_root + "/helpers/input/"
  end

  def out_file(tool)
    time = Time.now
    out_file = time.strftime("/usr/share/gladius/output/" + tool + "_%F_%T.txt")
  end

  def pid_file
    time = Time.now
    pid_tstamp = "%10.10f" % time.to_f
    pid_file = time.strftime(usr + "tmp/pids/" + pid_tstamp + ".pid")
  end
end
