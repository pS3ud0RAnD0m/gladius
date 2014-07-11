# Author: p$3ud0R@nD0m

class Hydra < Weapon
  def initialize(prev_menu, title)
    # Common
    @name = self.class.to_s.downcase
    @path = @name
    @prev_menu = prev_menu
    @stdin_hosts = Path.get("share_stdin_hosts")
    @title = title
    # Weapon specific
    @init_dir = Dir.pwd
    @port = ""
    @run_method = ""
    @share_output = Path.get("share_output")
    # Weapon specific lists
    @stdin_pwds = Path.get("share_stdin_pwds")
    @stdin_usrs = Path.get("share_stdin_usrs")    
    @pwds_long = ""
    @usrs_long = ""
  end

###############################################################################
# Menu methods
###############################################################################
  # Get target(s)
  def get_targets(run_method)
    @run_method = run_method
    header
# ttd_1: ask for port
    # Get port
    #case @run_method
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
    #when "vnc" then get_port(5900)
    #end
    Dir.chdir(@share_output)
    instruct_input_targets("fqdn", "ip")
    a = File.open(@stdin_hosts, "w")
    while line = gets
      a << line
    end
    a.close
    stdin_hosts = @stdin_hosts
    line_count = count_lines_file(stdin_hosts)
    if line_count == 0
      get_targets(@run_method)
    else
      puts "Select your tactic:".light_yellow
    end
    case @run_method
    when "rexec" then get_input_type("ssh")
    when "rlogin" then get_input_type("ssh")
    when "rsh" then get_input_type("ssh")
    when "vmauthd" then get_input_type("ssh")
    else
      get_input_type(@run_method)
    end
  rescue Interrupt
    GExeption.new.exit_weapon("Hydra", @prev_menu)
  end

  # Get input type
  def get_input_type(dictionary)
    case dictionary
    when "vnc" then
      @pwds_long = Path.get("#{dictionary}_pwds_long")
      pwds_count = count_lines_file(@pwds_long)
      puts "1. #{pwds_count} attempts/host = #{pwds_count} passwords"
    else
      @pwds_long = Path.get("#{dictionary}_pwds_long")
      @usrs_long = Path.get("#{dictionary}_usrs_long")
      pwds_count = count_lines_file(@pwds_long) + 2
      usrs_count = count_lines_file(@usrs_long)
      mult_count = usrs_count * pwds_count
      puts "1. #{mult_count} attempts/host = #{usrs_count} users * #{pwds_count} passwords"
    end
    puts "2. Input your own users and passwords"
    puts "3. Input your own user and password files"
    input_method = gets.to_i
    case input_method
    when 1 then send("#{@run_method}_gladius_long")
    when 2 then send("#{@run_method}_stdin")
    when 3 then send("#{@run_method}_stdin_list")
    end
  rescue Interrupt
    GExeption.new.exit_weapon("Hydra", @prev_menu)
  end

###############################################################################
# Run methods
###############################################################################
##################################
# FTP
##################################
# ttd_2: Run methods need significant refactoring.
  def ftp_gladius_long
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -e ns -L " + @usrs_long + " -P " + @pwds_long + " -M " + @stdin_hosts + " ftp |tee " + @out_file
    run(cmd)
    clean_exit("ftp")
  end

  def ftp_stdin
    instruct_input_usrs
    puts "root".yellow
    puts "ftp".yellow
    a = File.open(@stdin_usrs, "w")
    while line = gets
      a << line
    end
    a.close
    instruct_input_pwds
    puts "password".yellow
    puts "abc123".yellow
    a = File.open(@stdin_pwds, "w")
    while line = gets
      a << line
    end
    a.close
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L " + @stdin_usrs + " -P " + @stdin_pwds + " -M " + @stdin_hosts + " ftp |tee " + @out_file
    run(cmd)
    clean_exit("ftp")
  end
  
  def ftp_stdin_list
    instruct_input_usrs_list
    stdin_usrs = gets.chomp
    instruct_input_pwds_list
# ttd_3: Does not check for empty input.
    stdin_pwds = gets.chomp
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L #{stdin_usrs} -P #{stdin_pwds} -M " + @stdin_hosts + " ftp |tee " + @out_file
    run(cmd)
    clean_exit("ftp")
  end

##################################
# MSSQL
##################################
  def mssql_gladius_long
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 4 -w 64 -e ns -L " + @usrs_long + " -P " + @pwds_long + " -M " + @stdin_hosts + " mssql |tee " + @out_file
    run(cmd)
    clean_exit("mssql")
  end
  
  def mssql_stdin
    instruct_input_usrs
    puts "sa".yellow
    puts "dbadmin".yellow
    a = File.open(@stdin_usrs, "w")
    while line = gets
      a << line
    end
    a.close
    instruct_input_pwds
    puts "password".yellow
    puts "temp".yellow
    a = File.open(@stdin_pwds, "w")
    while line = gets
      a << line
    end
    a.close
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 4 -w 64 -L " + @stdin_usrs + " -P " + @stdin_pwds + " -M " + @stdin_hosts + " mssql |tee " + @out_file
    run(cmd)
    clean_exit("mssql")
  end
  
  def mssql_stdin_list
    instruct_input_usrs_list
    stdin_usrs = gets.chomp
    instruct_input_pwds_list
    stdin_pwds = gets.chomp
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 4 -w 64 -L #{stdin_usrs} -P #{stdin_pwds} -M " + @stdin_hosts + " mssql |tee " + @out_file
    run(cmd)
    clean_exit("mssql")
  end

##################################
# MySQL
##################################
  def mysql_gladius_long
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 4 -w 64 -e ns -L " + @usrs_long + " -P " + @pwds_long + " -M " + @stdin_hosts + " mysql |tee " + @out_file
    run(cmd)
    clean_exit("mysql")
  end
  
  def mysql_stdin
    instruct_input_usrs
    puts "root".yellow
    puts "mysql".yellow
    a = File.open(@stdin_usrs, "w")
    while line = gets
      a << line
    end
    a.close
    instruct_input_pwds
    puts "root".yellow
    puts "password".yellow
    puts "mysql".yellow
    puts "admin".yellow
    puts "toor".yellow
    puts "temp".yellow
    a = File.open(@stdin_pwds, "w")
    while line = gets
      a << line
    end
    a.close
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 4 -w 64 -L " + @stdin_usrs + " -P " + @stdin_pwds + " -M " + @stdin_hosts + " mysql |tee " + @out_file
    run(cmd)
    clean_exit("mysql")
  end
  
  def mysql_stdin_list
    instruct_input_usrs_list
    stdin_usrs = gets.chomp
    instruct_input_pwds_list
    stdin_pwds = gets.chomp
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 4 -w 64 -L #{stdin_usrs} -P #{stdin_pwds} -M " + @stdin_hosts + " mysql |tee " + @out_file
    run(cmd)
    clean_exit("mysql")
  end

##################################
# PostgreSQL
##################################
  def postgresql_gladius_long
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -e ns -L " + @usrs_long + " -P " + @pwds_long + " -M " + @stdin_hosts + " postgres |tee " + @out_file
    run(cmd)
    clean_exit("postgresql")
  end
  
  def postgresql_stdin
    instruct_input_usrs
    puts "password".yellow
    puts "postgres".yellow
    puts "admin".yellow
    puts "root".yellow
    a = File.open(@stdin_usrs, "w")
    while line = gets
      a << line
    end
    a.close
    instruct_input_pwds
    puts "password".yellow
    puts "postgres".yellow
    puts "admin".yellow
    puts "toor".yellow
    puts "temp".yellow
    a = File.open(@stdin_pwds, "w")
    while line = gets
      a << line
    end
    a.close
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L " + @stdin_usrs + " -P " + @stdin_pwds + " -M " + @stdin_hosts + " postgres |tee " + @out_file
    run(cmd)
    clean_exit("postgresql")
  end
  
  def postgresql_stdin_list
    instruct_input_usrs_list
    stdin_usrs = gets.chomp
    instruct_input_pwds_list
    stdin_pwds = gets.chomp
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L #{stdin_usrs} -P #{stdin_pwds} -M " + @stdin_hosts + " postgres |tee " + @out_file
    run(cmd)
    clean_exit("postgresql")
  end

##################################
# Rexec
##################################
  def rexec_gladius_long
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -e ns -L " + @usrs_long + " -P " + @pwds_long + " -M " + @stdin_hosts + " rexec -s 512 |tee " + @out_file
    run(cmd)
    clean_exit("rexec")
  end

  def rexec_stdin
    instruct_input_usrs
    puts "root".yellow
    a = File.open(@stdin_usrs, "w")
    while line = gets
      a << line
    end
    a.close
    instruct_input_pwds
    puts "root".yellow
    puts "password".yellow
    a = File.open(@stdin_pwds, "w")
    while line = gets
      a << line
    end
    a.close
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L " + @stdin_usrs + " -P " + @stdin_pwds + " -M " + @stdin_hosts + " rexec -s 512 |tee " + @out_file
    run(cmd)
    clean_exit("rexec")
  end
  
  def rexec_stdin_list
    instruct_input_usrs_list
    stdin_usrs = gets.chomp
    instruct_input_pwds_list
    stdin_pwds = gets.chomp
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L #{stdin_usrs} -P #{stdin_pwds} -M " + @stdin_hosts + " rexec -s 512 |tee " + @out_file
    run(cmd)
    clean_exit("rexec")
  end

##################################
# Rlogin
##################################
  def rlogin_gladius_long
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -e ns -L " + @usrs_long + " -P " + @pwds_long + " -M " + @stdin_hosts + " rlogin -s 513 |tee " + @out_file
    run(cmd)
    clean_exit("rlogin")
  end

  def rlogin_stdin
    instruct_input_usrs
    puts "root".yellow
    a = File.open(@stdin_usrs, "w")
    while line = gets
      a << line
    end
    a.close
    instruct_input_pwds
    puts "root".yellow
    puts "password".yellow
    a = File.open(@stdin_pwds, "w")
    while line = gets
      a << line
    end
    a.close
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L " + @stdin_usrs + " -P " + @stdin_pwds + " -M " + @stdin_hosts + " rlogin -s 513 |tee " + @out_file
    run(cmd)
    clean_exit("rlogin")
  end
  
  def rlogin_stdin_list
    instruct_input_usrs_list
    stdin_usrs = gets.chomp
    instruct_input_pwds_list
    stdin_pwds = gets.chomp
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L #{stdin_usrs} -P #{stdin_pwds} -M " + @stdin_hosts + " rlogin -s 513 |tee " + @out_file
    run(cmd)
    clean_exit("rlogin")
  end

##################################
# RSH
##################################
  def rsh_gladius_long
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -e ns -L " + @usrs_long + " -P " + @pwds_long + " -M " + @stdin_hosts + " rsh -s 514 |tee " + @out_file
    run(cmd)
    clean_exit("rsh")
  end

  def rsh_stdin
    instruct_input_usrs
    puts "root".yellow
    a = File.open(@stdin_usrs, "w")
    while line = gets
      a << line
    end
    a.close
    instruct_input_pwds
    puts "root".yellow
    puts "password".yellow
    a = File.open(@stdin_pwds, "w")
    while line = gets
      a << line
    end
    a.close
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L " + @stdin_usrs + " -P " + @stdin_pwds + " -M " + @stdin_hosts + " rsh -s 514 |tee " + @out_file
    run(cmd)
    clean_exit("rsh")
  end
  
  def rsh_stdin_list
    instruct_input_usrs_list
    stdin_usrs = gets.chomp
    instruct_input_pwds_list
    stdin_pwds = gets.chomp
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L #{stdin_usrs} -P #{stdin_pwds} -M " + @stdin_hosts + " rsh -s 514 |tee " + @out_file
    run(cmd)
    clean_exit("rsh")
  end

##################################
# SSH
##################################
  def ssh_gladius_long
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -e ns -L " + @usrs_long + " -P " + @pwds_long + " -M " + @stdin_hosts + " ssh -s 22 |tee " + @out_file
    run(cmd)
    clean_exit("ssh")
  end

  def ssh_stdin
    instruct_input_usrs
    puts "root".yellow
    a = File.open(@stdin_usrs, "w")
    while line = gets
      a << line
    end
    a.close
    instruct_input_pwds
    puts "root".yellow
    puts "password".yellow
    a = File.open(@stdin_pwds, "w")
    while line = gets
      a << line
    end
    a.close
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L " + @stdin_usrs + " -P " + @stdin_pwds + " -M " + @stdin_hosts + " ssh -s 22 |tee " + @out_file
    run(cmd)
    clean_exit("ssh")
  end
  
  def ssh_stdin_list
    instruct_input_usrs_list
    stdin_usrs = gets.chomp
    instruct_input_pwds_list
    stdin_pwds = gets.chomp
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L #{stdin_usrs} -P #{stdin_pwds} -M " + @stdin_hosts + " ssh -s 22 |tee " + @out_file
    run(cmd)
    clean_exit("ssh")
  end

##################################
# Telnet
##################################
  def telnet_gladius_long
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -e ns -L " + @usrs_long + " -P " + @pwds_long + " -M " + @stdin_hosts + " telnet -s 23 |tee " + @out_file
    run(cmd)
    clean_exit("telnet")
  end

  def telnet_stdin
    instruct_input_usrs
    puts "root".yellow
    puts "cisco".yellow
    a = File.open(@stdin_usrs, "w")
    while line = gets
      a << line
    end
    a.close
    instruct_input_pwds
    puts "cisco".yellow
    puts "password".yellow
    a = File.open(@stdin_pwds, "w")
    while line = gets
      a << line
    end
    a.close
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L " + @stdin_usrs + " -P " + @stdin_pwds + " -M " + @stdin_hosts + " telnet -s 23 |tee " + @out_file
    run(cmd)
    clean_exit("telnet")
  end
  
  def telnet_stdin_list
    instruct_input_usrs_list
    stdin_usrs = gets.chomp
    instruct_input_pwds_list
    stdin_pwds = gets.chomp
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L #{stdin_usrs} -P #{stdin_pwds} -M " + @stdin_hosts + " telnet -s 23 |tee " + @out_file
    run(cmd)
    clean_exit("telnet")
  end

##################################
# VNC
##################################`
  def vnc_gladius_long
    @out_file = Path.get_out_file_txt(@name)    
    cmd = @path + " -V -t 4 -w 64 -e ns -P " + @pwds_long + " -M " + @stdin_hosts + " vnc -s 5900 " + @port + " |tee " + @out_file
    run(cmd)
    clean_exit("vnc")
  end

  def vnc_stdin
    instruct_input_pwds
    puts "vncpass".yellow
    puts "password".yellow
    a = File.open(@stdin_pwds, "w")
    while line = gets
      a << line
    end
    a.close
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 4 -w 64 -P " + @stdin_pwds + " -M " + @stdin_hosts + " vnc -s 5900 " + @port + " |tee " + @out_file
    run(cmd)
    clean_exit("vnc")
  end
  
  def vnc_stdin_list
    instruct_input_pwds_list
    stdin_pwds = gets.chomp
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 4 -w 64 -P #{stdin_pwds} -M " + @stdin_hosts + " vnc -s 5900 " + @port + " |tee " + @out_file
    run(cmd)
    clean_exit("vnc")
  end
  
##################################
# VMAuthd
##################################
  def vmauthd_gladius_long
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -e ns -L " + @usrs_long + " -P " + @pwds_long + " -M " + @stdin_hosts + " vmauthd -s 902 |tee " + @out_file
    run(cmd)
    clean_exit("vmauthd")
  end

  def vmauthd_stdin
    instruct_input_usrs
    puts "root".yellow
    a = File.open(@stdin_usrs, "w")
    while line = gets
      a << line
    end
    a.close
    instruct_input_pwds
    puts "root".yellow
    puts "password".yellow
    a = File.open(@stdin_pwds, "w")
    while line = gets
      a << line
    end
    a.close
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L " + @stdin_usrs + " -P " + @stdin_pwds + " -M " + @stdin_hosts + " vmauthd -s 902 |tee " + @out_file
    run(cmd)
    clean_exit("vmauthd")
  end
  
  def vmauthd_stdin_list
    instruct_input_usrs_list
    stdin_usrs = gets.chomp
    instruct_input_pwds_list
    stdin_pwds = gets.chomp
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L #{stdin_usrs} -P #{stdin_pwds} -M " + @stdin_hosts + " vmauthd -s 902 |tee " + @out_file
    run(cmd)
    clean_exit("vmauthd")
  end

###############################################################################
# Exit method
###############################################################################
  # Parse and exit
  def clean_exit(search_term)
    Dir.chdir(@init_dir)
    if File.exist?(@out_file)
      results = open(@out_file) { |a| a.grep(/\[#{search_term}\]/) }
      if results.count == 0
        puts "Hydra did not find valid credentials.".light_yellow
      else
        puts "Hydra found the following credentials:".light_yellow
        puts results
      end
    end
    if File.exist?(@out_file)
      puts "Raw output can be found here:".yellow
      puts @out_file
    end
  exit_weapon
  end
end  
