# Author: p$3ud0R@nD0m

class Hydra < Weapon
  def initialize(prev_menu, title)
    @prev_menu = prev_menu
    @title = title
    @path = "hydra"
    @name = @path
    @stdn_hosts = Path.get_path("stdn_hosts")
    @ftp_pwds_long_long = Path.get_path("ftp_pwds_long")
    @ftp_usrs_long = Path.get_path("ftp_usrs_long")
    @mysql_pwds_long = Path.get_path("mysql_pwds_long")
    @mysql_usrs_long = Path.get_path("mysql_usrs_long")
    @ssh_pwds_long = Path.get_path("ssh_pwds_long")
    @ssh_usrs_long = Path.get_path("ssh_usrs_long")
    @stdn_pwds = Path.get_path("stdn_pwds")
    @stdn_usrs = Path.get_path("stdn_usrs")
    @telnet_pwds_long = Path.get_path("telnet_pwds_long")
    @telnet_usrs_long = Path.get_path("telnet_usrs_long")
  end

###############################################################################
# DRY methods
###############################################################################
  # Get target(s) and pass to relevant run method
  def menu(run_method)
    header
    instruct_input_targets("fqdn", "ip")
    a = File.open(@stdn_hosts, "w")
    while line = gets
      a << line
    end
    a.close
    stdn_hosts = @stdn_hosts
    line_count = `wc -l #{stdn_hosts}`.to_i
    puts
    case line_count
    when 0 then puts "No hosts were input.".red
      menu(run_method)
    when 1 then puts "Select your tactic:".light_yellow
      puts "Since only 1 host was input, we recommend option 1.".yellow
    when 2..5 then line_count = line_count.to_s
      puts "Select your tactic:".light_yellow
      puts "Since only #{line_count} hosts were input, we recommend option 1.".yellow
    else line_count = line_count.to_s
      puts "Since #{line_count} hosts were input, we recommend option 2 or 3.".yellow
    end
    
    case run_method
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
    when "telnet" then puts "1. 10,000 attempts/host = 10 users * 1,000 passwords"
    when "vmauthd" then puts
    when "vnc" then puts
    when "web-form" then puts
    end
    puts "2. Input your own users and passwords."
    puts "3. Input your own user and password lists."
    
    input_method = gets.to_i
    case run_method
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
    when "telnet"
      case input_method
        when 1 then telnet_gladius_long
        when 2 then telnet_stdn
        when 3 then telnet_stdn_list
      end
    #when "vmauthd" then vmauthd
    #when "vnc" then vnc
    #when "web-form" then web_form
    end
  rescue Interrupt
    GExeption.new.exit_weapon("Hydra", @prev_menu)
  end
  
  # Parse and exit
  def clean_exit(search_term)
    puts
    if File.exist?(@out_file)
      out_file = @out_file
      results = open(@out_file) { |a| a.grep(/\[#{search_term}\]/) }
      if results.count == 0
        puts "Hydra did not find valid credentials.".light_yellow
      else
        puts "Hydra found the following credentials:".light_yellow
        puts results
      end
    end
    puts
    if File.exist?(@out_file)
      puts "Raw output can be found here:".yellow
      puts @out_file
    end
  exit_weapon
  end

###############################################################################
# Run methods
###############################################################################
  def ftp_gladius_long
    @out_file = get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -e ns -L " + @ftp_usrs_long + " -P " + @ftp_pwds_long + " -M " + @stdn_hosts + " ftp |tee " + @out_file
    run(cmd)
    clean_exit("ftp")
  end

  def ftp_stdn
    instruct_input_usrs
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
    instruct_input_pwds
    puts "password".yellow
    puts "abc123".yellow
    puts
    a = File.open(@stdn_pwds, "w")
    while line = gets
      a << line
    end
    a.close
    stdn_pwds = @stdn_pwds
    @out_file = get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L " + @stdn_usrs + " -P " + @stdn_pwds + " -M " + @stdn_hosts + " ftp |tee " + @out_file
    run(cmd)
    clean_exit("ftp")
  end
  
  def ftp_stdn_list
    instruct_input_usrs_list
    stdn_usrs = gets.chomp
    puts
    instruct_input_pwds_list
    stdn_pwds = gets.chomp
    puts
    @out_file = get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L #{stdn_usrs} -P #{stdn_pwds} -M " + @stdn_hosts + " ftp |tee " + @out_file
    run(cmd)
    clean_exit("ftp")
  end

  def mysql_gladius_long
    @out_file = get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -e ns -L " + @mysql_usrs_long + " -P " + @mysql_pwds_long + " -M " + @stdn_hosts + " mysql |tee " + @out_file
    run(cmd)
    clean_exit("mysql")
  end
  
  def mysql_stdn
    instruct_input_usrs
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
    instruct_input_pwds
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
    @out_file = get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L " + @stdn_usrs + " -P " + @stdn_pwds + " -M " + @stdn_hosts + " mysql |tee " + @out_file
    run(cmd)
    clean_exit("mysql")
  end
  
  def mysql_stdn_list
    instruct_input_usrs_list
    stdn_usrs = gets.chomp
    puts
    instruct_input_pwds_list
    stdn_pwds = gets.chomp
    puts
    @out_file = get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L #{stdn_usrs} -P #{stdn_pwds} -M " + @stdn_hosts + " mysql |tee " + @out_file
    run(cmd)
    clean_exit("mysql")
  end

  def ssh_gladius_long
    @out_file = get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -e ns -L " + @ssh_usrs_long + " -P " + @ssh_pwds_long + " -M " + @stdn_hosts + " ssh -s 22 |tee " + @out_file
    run(cmd)
    clean_exit("ssh")
  end

  def ssh_stdn
    instruct_input_usrs
    puts "root".yellow
    puts
    a = File.open(@stdn_usrs, "w")
    while line = gets
      a << line
    end
    a.close
    stdn_usrs = @stdn_usrs
    puts
    instruct_input_pwds
    puts "root".yellow
    puts "password".yellow
    puts
    a = File.open(@stdn_pwds, "w")
    while line = gets
      a << line
    end
    a.close
    stdn_pwds = @stdn_pwds
    @out_file = get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L " + @stdn_usrs + " -P " + @stdn_pwds + " -M " + @stdn_hosts + " ssh -s 22 |tee " + @out_file
    run(cmd)
    clean_exit("ssh")
  end
  
  def ssh_stdn_list
    instruct_input_usrs_list
    stdn_usrs = gets.chomp
    puts
    instruct_input_pwds_list
    stdn_pwds = gets.chomp
    puts
    @out_file = get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L #{stdn_usrs} -P #{stdn_pwds} -M " + @stdn_hosts + " ssh -s 22 |tee " + @out_file
    run(cmd)
    clean_exit("ssh")
  end
  
  def telnet_gladius_long
    @out_file = get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -e ns -L " + @telnet_usrs_long + " -P " + @telnet_pwds_long + " -M " + @stdn_hosts + " telnet -s 23 |tee " + @out_file
    run(cmd)
    clean_exit("telnet")
  end

  def telnet_stdn
    instruct_input_usrs
    puts "root".yellow
    puts "cisco".yellow
    puts
    a = File.open(@stdn_usrs, "w")
    while line = gets
      a << line
    end
    a.close
    stdn_usrs = @stdn_usrs
    puts
    instruct_input_pwds
    puts "cisco".yellow
    puts "password".yellow
    puts
    a = File.open(@stdn_pwds, "w")
    while line = gets
      a << line
    end
    a.close
    stdn_pwds = @stdn_pwds
    @out_file = get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L " + @stdn_usrs + " -P " + @stdn_pwds + " -M " + @stdn_hosts + " telnet -s 23 |tee " + @out_file
    run(cmd)
    clean_exit("telnet")
  end
  
  def telnet_stdn_list
    instruct_input_usrs_list
    stdn_usrs = gets.chomp
    puts
    instruct_input_pwds_list
    stdn_pwds = gets.chomp
    puts
    @out_file = get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L #{stdn_usrs} -P #{stdn_pwds} -M " + @stdn_hosts + " telnet -s 23 |tee " + @out_file
    run(cmd)
    clean_exit("telnet")
  end
end  
