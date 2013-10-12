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
  end
  
  def req
    Dir[lib_root + "/menus/*.rb"].each { |a| require a }
    Dir[lib_root + "/tools/*.rb"].each { |a| require a }
    Dir[lib_root + "/helpers/*.rb"].each { |a| require a }
  end
  
  def usr
    usr = "/usr/share/gladius/"
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
