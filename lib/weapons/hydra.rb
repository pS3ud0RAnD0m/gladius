# Author: p$3ud0R@nD0m

class Hydra < Weapon
  def initialize(prev_menu, title)
    @prev_menu = prev_menu
    @title = title
    @path = "hydra"
    @name = @path
    @stdn_hosts = Path.get("share_stdn_hosts")
    @ftp_pwds_long = Path.get("ftp_pwds_long")
    @ftp_usrs_long = Path.get("ftp_usrs_long")
    @mssql_pwds_long = Path.get("mssql_pwds_long")
    @mssql_usrs_long = Path.get("mssql_usrs_long")
    @mysql_pwds_long = Path.get("mysql_pwds_long")
    @mysql_usrs_long = Path.get("mysql_usrs_long")
    @oracle_pwds_long = Path.get("oracle_pwds_long")
    @oracle_usrs_long = Path.get("oracle_usrs_long")
    @postgresql_pwds_long = Path.get("postgresql_pwds_long")
    @postgresql_usrs_long = Path.get("postgresql_usrs_long")
    @port = ""
    @ssh_pwds_long = Path.get("ssh_pwds_long")
    @ssh_usrs_long = Path.get("ssh_usrs_long")
    @stdn_pwds = Path.get("share_stdn_pwds")
    @stdn_usrs = Path.get("share_stdn_usrs")
    @telnet_pwds_long = Path.get("telnet_pwds_long")
    @telnet_usrs_long = Path.get("telnet_usrs_long")
    @vnc_pwds_long = Path.get("vnc_pwds_long")
    @vnc_usrs_long = Path.get("vnc_usrs_long")
  end

###############################################################################
# DRY methods
###############################################################################
  # Get target(s) and pass to relevant run method
  def menu(run_method)
    header
    # Get port
    #case run_method
    #when "ftp" then get_port(21)
    #when "http" then get_port(80)
    #when "mysql" then get_port(3306)
    #when "rexec" then get_port(512)
    #when "rlogin" then get_port(513)
    #when "rsh" then get_port(514)
    #when "smtp" then get_port(25)
    #when "ssh" then get_port(22)
    #when "telnet" then get_port(23)
    #when "vmauthd" then get_port(1)
# ttd_1: ask for port
    #when "vnc" then get_port(5900)
    #end
    
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
    when "cvs" then
    when "ftp" then count(@ftp_usrs_long, @ftp_pwds_long)
    when "http" then
    when "imap" then
    when "mssql" then count(@mssql_usrs_long, @mssql_pwds_long)
    when "mysql" then count(@mysql_usrs_long, @mysql_pwds_long)
    when "ncp" then
    when "nntp" then
    when "pcanywhere" then
    when "pop3" then
    when "postgresql" then count(@postgresql_usrs_long, @postgresql_pwds_long)
    when "rexec" then count(@ssh_usrs_long, @ssh_pwds_long)
    when "rlogin" then count(@ssh_usrs_long, @ssh_pwds_long)
    when "rsh" then count(@ssh_usrs_long, @ssh_pwds_long)
    when "smtp" then
    when "smtp-enum" then
    when "ssh" then count(@ssh_usrs_long, @ssh_pwds_long)
    when "svn" then
    when "telnet" then count(@telnet_usrs_long, @telnet_pwds_long)
    when "vmauthd" then count(@ssh_usrs_long, @ssh_pwds_long)
    when "vnc" then count(@vnc_usrs_long, @vnc_pwds_long)
    when "web-form" then
    end
    puts "2. Input your own users and passwords."
    puts "3. Input your own user and password files."
    
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
    when "mssql"
      case input_method
      when 1 then mssql_gladius_long
      when 2 then mssql_stdn
      when 3 then mssql_stdn_list
      end
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
    when "postgresql"
      case input_method
      when 1 then postgresql_gladius_long
      when 2 then postgresql_stdn
      when 3 then postgresql_stdn_list
      end
    when "rexec"
      case input_method
      when 1 then rexec_gladius_long
      when 2 then rexec_stdn
      when 3 then rexec_stdn_list
      end
    when "rlogin"
      case input_method
      when 1 then rlogin_gladius_long
      when 2 then rlogin_stdn
      when 3 then rlogin_stdn_list
      end
    when "rsh"
      case input_method
      when 1 then rsh_gladius_long
      when 2 then rsh_stdn
      when 3 then rsh_stdn_list
      end
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
    when "vmauthd"
      case input_method
      when 1 then vmauthd_gladius_long
      when 2 then vmauthd_stdn
      when 3 then vmauthd_stdn_list
      end
    when "vnc"
      case input_method
      when 1 then vnc_gladius_long
      when 2 then vnc_stdn
      when 3 then vnc_stdn_list
      end
    #when "web-form" then web_form
    end
  rescue Interrupt
    GExeption.new.exit_weapon("Hydra", @prev_menu)
  end

  # Parse and exit
  def clean_exit(search_term)
    puts
    if File.exist?(@out_file)
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
##################################
# FTP
##################################
  def ftp_gladius_long
    @out_file = Path.get_out_file_txt(@name)
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
    @out_file = Path.get_out_file_txt(@name)
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
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L #{stdn_usrs} -P #{stdn_pwds} -M " + @stdn_hosts + " ftp |tee " + @out_file
    run(cmd)
    clean_exit("ftp")
  end

##################################
# MSSQL
##################################
  def mssql_gladius_long
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 4 -w 64 -e ns -L " + @mssql_usrs_long + " -P " + @mssql_pwds_long + " -M " + @stdn_hosts + " mssql |tee " + @out_file
    run(cmd)
    clean_exit("mssql")
  end
  
  def mssql_stdn
    instruct_input_usrs
    puts "sa".yellow
    puts "dbadmin".yellow
    puts
    a = File.open(@stdn_usrs, "w")
    while line = gets
      a << line
    end
    a.close
    puts
    instruct_input_pwds
    puts "password".yellow
    puts "temp".yellow
    puts
    a = File.open(@stdn_pwds, "w")
    while line = gets
      a << line
    end
    a.close
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 4 -w 64 -L " + @stdn_usrs + " -P " + @stdn_pwds + " -M " + @stdn_hosts + " mssql |tee " + @out_file
    run(cmd)
    clean_exit("mssql")
  end
  
  def mssql_stdn_list
    instruct_input_usrs_list
    stdn_usrs = gets.chomp
    puts
    instruct_input_pwds_list
    stdn_pwds = gets.chomp
    puts
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 4 -w 64 -L #{stdn_usrs} -P #{stdn_pwds} -M " + @stdn_hosts + " mssql |tee " + @out_file
    run(cmd)
    clean_exit("mssql")
  end

##################################
# MySQL
##################################
  def mysql_gladius_long
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 4 -w 64 -e ns -L " + @mysql_usrs_long + " -P " + @mysql_pwds_long + " -M " + @stdn_hosts + " mysql |tee " + @out_file
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
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 4 -w 64 -L " + @stdn_usrs + " -P " + @stdn_pwds + " -M " + @stdn_hosts + " mysql |tee " + @out_file
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
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 4 -w 64 -L #{stdn_usrs} -P #{stdn_pwds} -M " + @stdn_hosts + " mysql |tee " + @out_file
    run(cmd)
    clean_exit("mysql")
  end

##################################
# PostgreSQL
##################################
  def postgresql_gladius_long
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -e ns -L " + @postgresql_usrs_long + " -P " + @postgresql_pwds_long + " -M " + @stdn_hosts + " postgres |tee " + @out_file
    run(cmd)
    clean_exit("postgresql")
  end
  
  def postgresql_stdn
    instruct_input_usrs
    puts "password".yellow
    puts "postgres".yellow
    puts "admin".yellow
    puts "root".yellow
    puts
    a = File.open(@stdn_usrs, "w")
    while line = gets
      a << line
    end
    a.close
    puts
    instruct_input_pwds
    puts "password".yellow
    puts "postgres".yellow
    puts "admin".yellow
    puts "toor".yellow
    puts "temp".yellow
    puts
    a = File.open(@stdn_pwds, "w")
    while line = gets
      a << line
    end
    a.close
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L " + @stdn_usrs + " -P " + @stdn_pwds + " -M " + @stdn_hosts + " postgres |tee " + @out_file
    run(cmd)
    clean_exit("postgresql")
  end
  
  def postgresql_stdn_list
    instruct_input_usrs_list
    stdn_usrs = gets.chomp
    puts
    instruct_input_pwds_list
    stdn_pwds = gets.chomp
    puts
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L #{stdn_usrs} -P #{stdn_pwds} -M " + @stdn_hosts + " postgres |tee " + @out_file
    run(cmd)
    clean_exit("postgresql")
  end

##################################
# Rexec
##################################
  def rexec_gladius_long
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -e ns -L " + @ssh_usrs_long + " -P " + @ssh_pwds_long + " -M " + @stdn_hosts + " rexec -s 512 |tee " + @out_file
    run(cmd)
    clean_exit("rexec")
  end

  def rexec_stdn
    instruct_input_usrs
    puts "root".yellow
    puts
    a = File.open(@stdn_usrs, "w")
    while line = gets
      a << line
    end
    a.close
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
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L " + @stdn_usrs + " -P " + @stdn_pwds + " -M " + @stdn_hosts + " rexec -s 512 |tee " + @out_file
    run(cmd)
    clean_exit("rexec")
  end
  
  def rexec_stdn_list
    instruct_input_usrs_list
    stdn_usrs = gets.chomp
    puts
    instruct_input_pwds_list
    stdn_pwds = gets.chomp
    puts
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L #{stdn_usrs} -P #{stdn_pwds} -M " + @stdn_hosts + " rexec -s 512 |tee " + @out_file
    run(cmd)
    clean_exit("rexec")
  end

##################################
# Rlogin
##################################
  def rlogin_gladius_long
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -e ns -L " + @ssh_usrs_long + " -P " + @ssh_pwds_long + " -M " + @stdn_hosts + " rlogin -s 513 |tee " + @out_file
    run(cmd)
    clean_exit("rlogin")
  end

  def rlogin_stdn
    instruct_input_usrs
    puts "root".yellow
    puts
    a = File.open(@stdn_usrs, "w")
    while line = gets
      a << line
    end
    a.close
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
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L " + @stdn_usrs + " -P " + @stdn_pwds + " -M " + @stdn_hosts + " rlogin -s 513 |tee " + @out_file
    run(cmd)
    clean_exit("rlogin")
  end
  
  def rlogin_stdn_list
    instruct_input_usrs_list
    stdn_usrs = gets.chomp
    puts
    instruct_input_pwds_list
    stdn_pwds = gets.chomp
    puts
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L #{stdn_usrs} -P #{stdn_pwds} -M " + @stdn_hosts + " rlogin -s 513 |tee " + @out_file
    run(cmd)
    clean_exit("rlogin")
  end

##################################
# RSH
##################################
  def rsh_gladius_long
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -e ns -L " + @ssh_usrs_long + " -P " + @ssh_pwds_long + " -M " + @stdn_hosts + " rsh -s 514 |tee " + @out_file
    run(cmd)
    clean_exit("rsh")
  end

  def rsh_stdn
    instruct_input_usrs
    puts "root".yellow
    puts
    a = File.open(@stdn_usrs, "w")
    while line = gets
      a << line
    end
    a.close
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
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L " + @stdn_usrs + " -P " + @stdn_pwds + " -M " + @stdn_hosts + " rsh -s 514 |tee " + @out_file
    run(cmd)
    clean_exit("rsh")
  end
  
  def rsh_stdn_list
    instruct_input_usrs_list
    stdn_usrs = gets.chomp
    puts
    instruct_input_pwds_list
    stdn_pwds = gets.chomp
    puts
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L #{stdn_usrs} -P #{stdn_pwds} -M " + @stdn_hosts + " rsh -s 514 |tee " + @out_file
    run(cmd)
    clean_exit("rsh")
  end

##################################
# SSH
##################################
  def ssh_gladius_long
    @out_file = Path.get_out_file_txt(@name)
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
    @out_file = Path.get_out_file_txt(@name)
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
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L #{stdn_usrs} -P #{stdn_pwds} -M " + @stdn_hosts + " ssh -s 22 |tee " + @out_file
    run(cmd)
    clean_exit("ssh")
  end

##################################
# Telnet
##################################
  def telnet_gladius_long
    @out_file = Path.get_out_file_txt(@name)
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
    @out_file = Path.get_out_file_txt(@name)
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
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L #{stdn_usrs} -P #{stdn_pwds} -M " + @stdn_hosts + " telnet -s 23 |tee " + @out_file
    run(cmd)
    clean_exit("telnet")
  end

##################################
# VNC
##################################`

  def vnc_gladius_long
    @out_file = Path.get_out_file_txt(@name)
    #puts @vnc_usrs_long
    #puts @vnc_pwds_long
    #puts @stdn_hosts
    #puts @port
    #puts @out_file
    
    cmd = @path + " -V -t 4 -w 64 -e ns -P " + @vnc_pwds_long + " -M " + @stdn_hosts + " vnc -s 5900 " + @port + " |tee " + @out_file
    run(cmd)
    clean_exit("vnc")
  end

  def vnc_stdn
    instruct_input_pwds
    puts "vncpass".yellow
    puts "password".yellow
    puts
    a = File.open(@stdn_pwds, "w")
    while line = gets
      a << line
    end
    a.close
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 4 -w 64 -P " + @stdn_pwds + " -M " + @stdn_hosts + " vnc -s 5900 " + @port + " |tee " + @out_file
    run(cmd)
    clean_exit("vnc")
  end
  
  def vnc_stdn_list
    instruct_input_pwds_list
    stdn_pwds = gets.chomp
    puts
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 4 -w 64 -P #{stdn_pwds} -M " + @stdn_hosts + " vnc -s 5900 " + @port + " |tee " + @out_file
    run(cmd)
    clean_exit("vnc")
  end
  
##################################
# VMAuthd
##################################
  def vmauthd_gladius_long
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -e ns -L " + @ssh_usrs_long + " -P " + @ssh_pwds_long + " -M " + @stdn_hosts + " vmauthd -s 902 |tee " + @out_file
    run(cmd)
    clean_exit("vmauthd")
  end

  def vmauthd_stdn
    instruct_input_usrs
    puts "root".yellow
    puts
    a = File.open(@stdn_usrs, "w")
    while line = gets
      a << line
    end
    a.close
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
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L " + @stdn_usrs + " -P " + @stdn_pwds + " -M " + @stdn_hosts + " vmauthd -s 902 |tee " + @out_file
    run(cmd)
    clean_exit("vmauthd")
  end
  
  def vmauthd_stdn_list
    instruct_input_usrs_list
    stdn_usrs = gets.chomp
    puts
    instruct_input_pwds_list
    stdn_pwds = gets.chomp
    puts
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L #{stdn_usrs} -P #{stdn_pwds} -M " + @stdn_hosts + " vmauthd -s 902 |tee " + @out_file
    run(cmd)
    clean_exit("vmauthd")
  end
end  
