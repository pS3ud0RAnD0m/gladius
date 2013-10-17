#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

class Hydra < Tool
  def initialize(title)
    @title = title
    @path = "hydra"
    @name = @path
    @hosts_file = Path.hosts_file
    @ftp_pwds = Path.ftp_pwds
    @ftp_usrs = Path.ftp_usrs
    @mysql_pwds = Path.mysql_pwds
    @mysql_usrs = Path.mysql_usrs
    @ssh_pwds = Path.ssh_pwds
    @ssh_usrs = Path.ssh_usrs
    @stdn_pwds = Path.stdn_pwds
    @stdn_usrs = Path.stdn_usrs
  end

  def menu(scan_type)
    header
    instruct_input_targets("fqdn", "ip")
    a = File.open(@hosts_file, "w")
    while line = gets
      a << line
    end
    a.close
    hosts = @hosts_file
    line_count = `wc -l #{hosts} |awk '{print $1}'`.to_i
    puts
    case line_count
      when 0 then puts "No hosts were input.".red
        menu
      when 1 then puts "Select your tactic:".light_yellow
        puts "Since only 1 host was input, we recommend option 1.".yellow
      when 2..5 then line_count = line_count.to_s
        puts "Select your tactic:".light_yellow
        puts "Since only #{line_count} hosts were input, we recommend option 1.".yellow
      else line_count = line_count.to_s
        puts "Since #{line_count} hosts were input, we recommend option 2 or 3.".yellow
    end
    case scan_type
      when "cvs" then puts
      when "ftp" then puts "1. 476 attempts/host = 14 users * 34 passwords"
      when "http" then puts
      when "imap" then puts
      when "mssql" then puts
      when "mysql" then puts "1. 12 attempts/host = 2 users * 6 passwords"
      when "ncp" then puts
      when "nntp" then puts
      when "pcanywhere" then puts
      when "pop3" then puts
      when "postgres" then puts
      when "rexec" then puts
      when "rlogin" then puts
      when "rsh" then puts
      when "smb" then puts
      when "smtp" then puts
      when "smtp-enum" then puts
      when "ssh" then puts "1. 10,000 attempts/host = 10 users * 1,000 passwords"
      when "svn" then puts
      when "telnet" then puts
      when "vmauthd" then puts
      when "vnc" then puts
      when "web-form" then puts
    end
    puts "2. Input your own users and passwords."
    puts "3. Input your own user and password lists."
    input_method = gets.to_i
    puts
    case scan_type
      #when "cvs" then cvs
      when "ftp"
        case input_method
          when 1 then ftp_gladius_long
          when 2 then ftp_stdn
          when 3 then ftp_stdn_list
        end
      #when "http" then http
      #when "imap" then imap
      #when "mssql" then mssql
      when "mysql"
        case input_method
          when 1 then mysql_gladius_long
          when 2 then mysql_stdn
          when 3 then mysql_stdn_list
        end
      #when "ncp" then ncp
      #when "nntp" then nntp
      #when "pcanywhere" then pcanywhere
      #when "pop3" then pop3
      #when "postgres" then postgres
      #when "rexec" then rexec
      #when "rlogin" then rlogin
      #when "rsh" then rsh
      #when "smb" then smb
      #when "smtp" then smtp
      #when "smtp-enum" then smtp_enum
      when "ssh"
        case input_method
          when 1 then ssh_gladius_long
          when 2 then ssh_stdn
          when 3 then ssh_stdn_list
        end
      #when "svn" then svn
      #when "telnet" then telnet
      #when "vmauthd" then vmauthd
      #when "vnc" then vnc
      #when "web-form" then web_form
    end
  rescue Interrupt
    GExeption.new.exit_tool("Hydra", "DictionaryOnline")
  end
  
  # Parse and exit
  def clean_exit(search_term)
    puts
    out_file = @out_file
    rslt = open(@out_file) { |a| a.grep(/\[#{search_term}\]/) }
    if rslt.count == 0
      puts "Hydra did not find valid credentials.".light_yellow
    else
      puts "Hydra found the following credentials:".light_yellow
      puts rslt
    end
    puts
    puts "Raw output can be found here:".yellow
    puts out_file
    puts
    DictionaryOnline.new("Online Dictionary Attacks").menu
  rescue Interrupt
    GExeption.new.exit_gladius
  end
  
  def ftp_gladius_long
    @out_file = get_out_file(@name) + ".txt"
    cmd = @path + " -V -t 8 -w 64 -e ns -L " + @ftp_usrs + " -P " + @ftp_pwds + " -M " + @hosts_file + " ftp |tee " + @out_file
    run(cmd)
    clean_exit("ftp")
  end

  def ftp_stdn
    instruct_input_usrs
    puts "Examples:".yellow
    puts "root".yellow
    puts "ftp".yellow
    puts
    a = File.open(@stdn_usrs, "w")
    while line = gets
      a << line
    end
    a.close
    stdn_usrs = @stdn_usrs
    puts
    instruct_input_pswds
    puts "Examples:".yellow
    puts "password".yellow
    puts "abc123".yellow
    puts
    a = File.open(@stdn_pwds, "w")
    while line = gets
      a << line
    end
    a.close
    stdn_pwds = @stdn_pwds
    @out_file = get_out_file(@name) + ".txt"
    cmd = @path + " -V -t 8 -w 64 -L " + @stdn_usrs + " -P " + @stdn_pwds + " -M " + @hosts_file + " ftp |tee " + @out_file
    run(cmd)
    clean_exit("ftp")
  end
  
  def ftp_stdn_list
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
    @out_file = get_out_file(@name) + ".txt"
    cmd = @path + " -V -t 8 -w 64 -L #{usrs_lst} -P #{pwds_lst} -M " + @hosts_file + " ftp |tee " + @out_file
    run(cmd)
    clean_exit("ftp")
  end

  def mysql_gladius_long
    @out_file = get_out_file(@name) + ".txt"
    cmd = @path + " -V -t 8 -w 64 -e ns -L " + @mysql_usrs + " -P " + @mysql_pwds + " -M " + @hosts_file + " mysql |tee " + @out_file
    run(cmd)
    clean_exit("mysql")
  end
  
  def mysql_stdn
    instruct_input_usrs
    puts "Examples:".yellow
    puts "root".yellow
    puts "mysql".yellow
    puts
    a = File.open(@stdn_usrs, "w")
    while line = gets
      a << line
    end
    a.close
    stdn_usrs = @stdn_usrs
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
    a = File.open(@stdn_pwds, "w")
    while line = gets
      a << line
    end
    a.close
    stdn_pwds = @stdn_pwds
    @out_file = get_out_file(@name) + ".txt"
    cmd = @path + " -V -t 8 -w 64 -L " + @stdn_usrs + " -P " + @stdn_pwds + " -M " + @hosts_file + " mysql |tee " + @out_file
    run(cmd)
    clean_exit("mysql")
  end
  
  def mysql_stdn_list
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
    @out_file = get_out_file(@name) + ".txt"
    cmd = @path + " -V -t 8 -w 64 -L #{usrs_lst} -P #{pwds_lst} -M " + @hosts_file + " mysql |tee " + @out_file
    run(cmd)
    clean_exit("mysql")
  end

  def ssh_gladius_long
    @out_file = get_out_file(@name) + ".txt"
    cmd = @path + " -V -t 8 -w 64 -e ns -L " + @ssh_usrs + " -P " + @ssh_pwds + " -M " + @hosts_file + " ssh -s 22 |tee " + @out_file
    run(cmd)
    clean_exit("ssh")
  end

  def ssh_stdn
    instruct_input_usrs
    puts "Examples:".yellow
    puts "root".yellow
    puts
    a = File.open(@stdn_usrs, "w")
    while line = gets
      a << line
    end
    a.close
    stdn_usrs = @stdn_usrs
    puts
    instruct_input_pswds
    puts "Examples:".yellow
    puts "root".yellow
    puts "password".yellow
    puts
    a = File.open(@stdn_pwds, "w")
    while line = gets
      a << line
    end
    a.close
    stdn_pwds = @stdn_pwds
    @out_file = get_out_file(@name) + ".txt"
    cmd = @path + " -V -t 8 -w 64 -L " + @stdn_usrs + " -P " + @stdn_pwds + " -M " + @hosts_file + " ssh |tee " + @out_file
    run(cmd)
    clean_exit("ssh")
  end
  
  def ssh_stdn_list
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
    @out_file = get_out_file(@name) + ".txt"
    cmd = @path + " -V -t 8 -w 64 -L #{usrs_lst} -P #{pwds_lst} -M " + @hosts_file + " ssh |tee " + @out_file
    run(cmd)
    clean_exit("ssh")
  end
end  
