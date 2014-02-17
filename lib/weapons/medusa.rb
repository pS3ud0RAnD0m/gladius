# Author: p$3ud0R@nD0m

class Hydra < Weapon
  def initialize(prev_menu, title)
    @prev_menu = prev_menu
    @title = title
    @path = "hydra"
    @name = @path
    @stdn_hosts = Path.get("share_stdn_hosts")
    @smb_pwds_long = Path.get("smb_pwds_long")
    @smb_usrs_long = Path.get("smb_usrs_long")
    @mysql_pwds_long = Path.get("mysql_pwds_long")
    @mysql_usrs_long = Path.get("mysql_usrs_long")
    @postgresql_pwds_long = Path.get("postgresql_pwds_long")
    @postgresql_usrs_long = Path.get("postgresql_usrs_long")
    @ssh_pwds_long = Path.get("ssh_pwds_long")
    @ssh_usrs_long = Path.get("ssh_usrs_long")
    @stdn_pwds = Path.get("share_stdn_pwds")
    @stdn_usrs = Path.get("share_stdn_usrs")
    @telnet_pwds_long = Path.get("telnet_pwds_long")
    @telnet_usrs_long = Path.get("telnet_usrs_long")
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
    when "smb" then puts "1. 476 attempts/host = 14 users * 34 passwords"
    end
    puts "2. Input your own users and passwords."
    puts "3. Input your own user and password files."
    
    input_method = gets.to_i
    case run_method
    when "smb"
      case input_method
      when 1 then smb_gladius_long
      when 2 then smb_stdn
      when 3 then smb_stdn_list
      end
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
  def smb_gladius_long
    @out_file = get_out_file_txt(@name)
#      i.cmd = @@path + " -H " + @@hosts + " -U " + @@sshulist + " -P " + @@sshplist + " -M ssh -n 7750 -e ns -O " + @@out_file

    cmd = @path + " -V -t 8 -w 64 -e ns -L " + @smb_usrs_long + " -P " + @smb_pwds_long + " -M " + @stdn_hosts + " smb |tee " + @out_file
    run(cmd)
    clean_exit("smb")
  end

  def smb_stdn
    instruct_input_usrs
    puts "root".yellow
    puts "smb".yellow
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
    @out_file = get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L " + @stdn_usrs + " -P " + @stdn_pwds + " -M " + @stdn_hosts + " smb |tee " + @out_file
    run(cmd)
    clean_exit("smb")
  end
  
  def smb_stdn_list
    instruct_input_usrs_list
    stdn_usrs = gets.chomp
    puts
    instruct_input_pwds_list
    stdn_pwds = gets.chomp
    puts
    @out_file = get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L #{stdn_usrs} -P #{stdn_pwds} -M " + @stdn_hosts + " smb |tee " + @out_file
    run(cmd)
    clean_exit("smb")
  end
end  
