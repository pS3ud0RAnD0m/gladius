# Author: p$3ud0R@nD0m

class Ncrack < Weapon
  def initialize(prev_menu, title)
    # Common
    @name = self.class.to_s.downcase
    @path = @name
    @prev_menu = prev_menu
    @stdin_hosts = Path.get("share_stdin_hosts")
    @title = title
    # Weapon specific lists
    @stdin_pwds = Path.get("share_stdin_pwds")
    @stdin_usrs = Path.get("share_stdin_usrs")
    @windows_pwds_long = Path.get("windows_pwds_long")
    @windows_usrs_long = Path.get("windows_usrs_long")
  end

###############################################################################
# DRY methods
###############################################################################
  # Get target(s) and pass to relevant run method
  def menu(run_method)
    header
    instruct_input_targets("fqdn", "ip", "ipr", "iprl", "iprf", "cidr")
    a = File.open(@stdin_hosts, "w")
    while line = gets
      a << line
    end
    a.close
    stdin_hosts = @stdin_hosts
    line_count = `wc -l #{stdin_hosts}`.to_i
    puts
    case line_count
    when 0 then no_input
      menu(run_method)
# ttd_2: Improper exit: no input > cntl+c > cntl + c > ? (affecting other weapons?)
    when 1 then puts "Select your tactic:".light_yellow
      puts "Since only 1 host was input, we recommend option 1.".yellow
    when 2..5 then line_count = line_count.to_s
      puts "Select your tactic:".light_yellow
      puts "Since only #{line_count} hosts were input, we recommend option 1.".yellow
    else line_count = line_count.to_s
      puts "Since #{line_count} hosts were input, we recommend option 2 or 3.".yellow
    end

    case run_method
    when "rdp" then count(@windows_usrs_long, @windows_pwds_long)
    when "smb" then count(@windows_usrs_long, @windows_pwds_long)
    end
    puts "2. Input your own users and passwords."
    puts "3. Input your own user and password files."

    input_method = gets.to_i
    case run_method
    when "rdp"
      case input_method
      when 1 then rdp_gladius_long
      when 2 then rdp_stdin
      when 3 then rdp_stdin_list
      end
    when "smb"
      case input_method
      when 1 then smb_gladius_long
      when 2 then smb_stdin
      when 3 then smb_stdin_list
      end
    end
  rescue Interrupt
    GExeption.new.exit_weapon("Ncrack", @prev_menu)
  end

# ttd_2: Parse Ncrack output
  # Parse and exit
  def clean_exit(search_term)
    puts
    #if File.exist?(@out_file)
    #  out_file = @out_file
    #  results = open(@out_file) { |a| a.grep(/\[#{search_term}\]/) }
    #  if results.count == 0
    #    puts "Ncrack did not find valid credentials.".light_yellow
    #  else
    #    puts "Ncrack found the following credentials:".light_yellow
    #    puts results
    #  end
    #end
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
# RDP
##################################
  def rdp_gladius_long
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -v -p3389 -U " + @windows_usrs_long + " -P " + @windows_pwds_long + " -iL " + @stdin_hosts + " |tee " + @out_file
    run(cmd)
    clean_exit("rdp")
  end

  def rdp_stdin
    instruct_input_usrs("windows")
    a = File.open(@stdin_usrs, "w")
    while line = gets
      a << line
    end
    a.close
    puts
    instruct_input_pwds("windows")
    a = File.open(@stdin_pwds, "w")
    while line = gets
      a << line
    end
    a.close
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L " + @stdin_usrs + " -P " + @stdin_pwds + " -M " + @stdin_hosts + " ftp |tee " + @out_file
    run(cmd)
    clean_exit("rdp")
  end
  
  def rdp_stdin_list
    instruct_input_usrs_list
    stdin_usrs = gets.chomp
    puts
    instruct_input_pwds_list
    stdin_pwds = gets.chomp
    puts
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L #{stdin_usrs} -P #{stdin_pwds} -M " + @stdin_hosts + " ftp |tee " + @out_file
    run(cmd)
    clean_exit("rdp")
  end

##################################
# SMB
##################################
  def smb_gladius_long
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -v -U " + @stdin_usrs + " -P " + @stdin_pwds + " -iL " + @stdin_hosts + ":3389 |tee " + @out_file
    run(cmd)
    clean_exit("smb")
  end

  def smb_stdin
    instruct_input_usrs("windows")
    a = File.open(@stdin_usrs, "w")
    while line = gets
      a << line
    end
    a.close
    puts
    instruct_input_pwds("windows")
    a = File.open(@stdin_pwds, "w")
    while line = gets
      a << line
    end
    a.close
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L " + @stdin_usrs + " -P " + @stdin_pwds + " -M " + @stdin_hosts + " ftp |tee " + @out_file
    run(cmd)
    clean_exit("smb")
  end
  
  def smb_stdin_list
    instruct_input_usrs_list
    stdin_usrs = gets.chomp
    puts
    instruct_input_pwds_list
    stdin_pwds = gets.chomp
    puts
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -V -t 8 -w 64 -L #{stdin_usrs} -P #{stdin_pwds} -M " + @stdin_hosts + " ftp |tee " + @out_file
    run(cmd)
    clean_exit("smb")
  end
end  
