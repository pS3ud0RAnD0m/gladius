#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

module Path
  def out_file(tool)
    time = Time.now
    out_file = time.strftime("/usr/share/gladius/output/#{tool}_%F_%T.txt")
  end

  def pid_file
    time = Time.now
    #pid_file = time.strftime("/usr/share/gladius/tmp/pids/%F_%T.pid")
    
    pid_tstamp = "%10.10f" % time.to_f
    pid_file = time.strftime("/usr/share/gladius/tmp/pids/#{pid_tstamp}.pid")
  end
end

#include Path
#puts out_file("gladius")
#puts pid_file
