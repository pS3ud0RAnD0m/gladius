# Author: p$3ud0R@nD0m

class Medusa < Weapon
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
# User interaction methods
###############################################################################

  # Get target(s) and pass to relevant run method
  def menu(run_method)
    header
    instruct_input_targets("fqdn", "ip")
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
    when 1 then puts "Select your tactic:".light_yellow
      puts "Since only 1 host was input, we recommend option 1.".yellow
    when 2..5 then line_count = line_count.to_s
      puts "Select your tactic:".light_yellow
      puts "Since only #{line_count} hosts were input, we recommend option 1.".yellow
    else line_count = line_count.to_s
      puts "Since #{line_count} hosts were input, we recommend option 2 or 3.".yellow
    end

    case run_method
    when "smb" then count(@windows_usrs_long, @windows_pwds_long)
    end
    puts "2. Input your own users and passwords."
    puts "3. Input your own user and password files."
    input_method = gets.to_i
    case run_method
    when "smb"
      case input_method
      when 1 then smb_gladius_long
      when 2 then smb_stdin
      when 3 then smb_stdin_list
      end
    end
  rescue Interrupt
    GExeption.new.exit_weapon("Medusa", @prev_menu)
  end
  
  # Parse and exit
  def clean_exit
    puts
    if File.exist?(@out_file)
      results = open(@out_file) { |a| a.grep(/SUCCESS/) }
      if results.count == 0
        puts "Medusa did not find valid credentials.".light_yellow
        puts "Eyeballing raw output may yield useful info, such as \"Anonymous success\".".yellow
      else
        puts "Medusa found the following credentials:".light_yellow
        puts results
        puts "Eyeballing raw output may yield more useful info, such as \"Anonymous success\".".yellow
      end
     end
    if File.exist?(@out_file)
      puts "Raw output can be found here:".yellow
      puts @out_file
    end
  exit_weapon
  end

###############################################################################
# Execution methods
###############################################################################
##################################
# SMB
##################################
  def smb_gladius_long
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -e ns -U " + @windows_usrs_long + " -P " + @windows_pwds_long + " -H " + @stdin_hosts + " -M smbnt |tee " + @out_file
    run(cmd)
    clean_exit
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
    cmd = @path + " -e ns -U " + @stdin_usrs + " -P " + @stdin_pwds + " -H " + @stdin_hosts + " -M smbnt |tee " + @out_file
    run(cmd)
    clean_exit
  end

  def smb_stdin_list
    instruct_input_usrs_list
    stdin_usrs = gets.chomp
    puts
    instruct_input_pwds_list
    stdin_pwds = gets.chomp
    puts
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -e ns -U #{stdin_usrs} -P #{stdin_pwds} -H " + @stdin_hosts + " -M smbnt |tee " + @out_file
    run(cmd)
    clean_exit
  end
end  
