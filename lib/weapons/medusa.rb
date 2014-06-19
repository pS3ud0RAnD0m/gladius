# Author: p$3ud0R@nD0m

# ttd_2: Port this gnmap class to medusa

class Medusa < Weapon
  def initialize(prev_menu, title)
    @prev_menu = prev_menu
    @title = title
    @path = "medusa"
    @name = @path
    @cmd = ""
    @stdn_hosts = Path.get("share_stdn_hosts")
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
# ttd_1: autocount all non-hydra dictionary attacks
    when "smb" then puts "1. 178 attempts/host = 16 users * 13 passwords"
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
        puts "Medusa did not find valid credentials. Eyeballing raw output may yield useful info.".light_yellow
      else
        puts "Medusa found the following credentials:".light_yellow
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
    clean_exit("smb")
  end
  
# Execute run methods
  def execute(run_method)
    @out_file = Path.get_out_file(@name)
    prependix = @path + " -v -Pn -s"
    appendix = " -iL " + @stdn_hosts + " -oA " + @out_file
      case run_method
      when "custom" then custom
        cmd = @cmd
      when "ping_discovery" then cmd = @path +             " -v -T4 -sn --min-hostgroup 256 -iL " + @stdn_hosts + " -oA " + @out_file
      when "script_smb_anon" then cmd = prependix +        "S -p21 --script smb-anon" + appendix
      when "script_http_methods" then cmd = prependix +    "S -p80,443 --script http-methods" + appendix
      when "script_smtp_open_relay" then cmd = prependix + "S -p25,465,587 --script smtp-open-relay" + appendix
      when "script_snmp_dictionary" then cmd = prependix + "U -p161 --script snmp-brute --script-args snmp-brute.communitiesdb=" + @snmp_comm_strings_long + appendix
      when "script_tsmb_files" then cmd = prependix +      "U -p69 --script tsmb-enum" + appendix
      when "tcp_full" then cmd = prependix +               "S -T4 --min-hostgroup 128 -p1-65535" + appendix
      when "tcp_quick_scripts" then cmd = prependix +      "SV -T4 --script all --min-hostgroup 128" + appendix
      when "tcp_quick" then cmd = prependix +              "S -T4 --min-hostgroup 128" + appendix
      when "tcp_udp_full" then cmd = prependix +           "SU -T4 --min-hostgroup 128 -p1-65535" + appendix
      when "tcp_udp_quick_scripts" then cmd = prependix +  "SUV -Pn --script=all --min-hostgroup 128" + appendix
      when "tcp_udp_quick" then cmd = prependix +          "SU -T4 --min-hostgroup 128" + appendix
      when "tcp_very_quick_lan" then cmd = prependix +     "S -T5 --top-ports 25 --min-hostgroup 256" + appendix
      when "tcp_very_quick_wan" then cmd = prependix +     "S -T4 --top-ports 25 --min-hostgroup 256" + appendix
      when "udp_full" then cmd = prependix +               "U -T4 --min-hostgroup 128 -p1-65535" + appendix
      when "udp_quick_scripts" then cmd = prependix +      "UV -T4 --script=all --min-hostgroup 128" + appendix
      when "udp_quick" then cmd = prependix +              "U -T4 --min-hostgroup 128" + appendix
      end
    run(cmd)
    clean_exit
  end


end  
