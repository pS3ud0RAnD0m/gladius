# Author: p$3ud0R@nD0m

class Medusa < Weapon
  def initialize(prev_menu, title)
    # Common
    @name = self.class.to_s.downcase
    @path = @name
    @prev_menu = prev_menu
    @stdn_hosts = Path.get("share_stdn_hosts")
    @title = title
    # Weapon specific lists
    @stdn_pwds = Path.get("share_stdn_pwds")
    @stdn_usrs = Path.get("share_stdn_usrs")
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
    a = File.open(@stdn_hosts, "w")
    while line = gets
      a << line
    end
    a.close
    stdn_hosts = @stdn_hosts
    line_count = `wc -l #{stdn_hosts}`.to_i
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
      when 2 then smb_stdn
      when 3 then smb_stdn_list
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
    cmd = @path + " -e ns -U " + @windows_usrs_long + " -P " + @windows_pwds_long + " -H " + @stdn_hosts + " -M smbnt |tee " + @out_file
    run(cmd)
    clean_exit
  end

  def smb_stdn
    instruct_input_usrs
    puts "administrator".yellow
    puts "backup".yellow
    puts
    a = File.open(@stdn_usrs, "w")
    while line = gets
      a << line
    end
    a.close
    puts
    instruct_input_pwds
    puts "password".yellow
    puts "password1".yellow
    puts
    a = File.open(@stdn_pwds, "w")
    while line = gets
      a << line
    end
    a.close
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -e ns -U " + @stdn_usrs + " -P " + @stdn_pwds + " -H " + @stdn_hosts + " -M smbnt |tee " + @out_file
    run(cmd)
    clean_exit
  end

  def smb_stdn_list
    instruct_input_usrs_list
    stdn_usrs = gets.chomp
    puts
    instruct_input_pwds_list
    stdn_pwds = gets.chomp
    puts
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -e ns -U #{stdn_usrs} -P #{stdn_pwds} -H " + @stdn_hosts + " -M smbnt |tee " + @out_file
    run(cmd)
    clean_exit
  end
end  
