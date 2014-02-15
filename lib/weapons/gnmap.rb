# Author: p$3ud0R@nD0m

class GNmap < Weapon
  def initialize(prev_menu, title)
    @prev_menu = prev_menu
    @title = title
    @path = "nmap"
    @name = @path
    @cmd = ""
    @stdn_hosts = Path.get_path("stdn_hosts")
    @snmp_comm_strings_long = Path.get_path("snmp_comm_strings_long")
    @tftp_file_list = Path.get_path("tftp_file_list")
  end

###############################################################################
# User interaction methods
###############################################################################
  # Get target(s) and pass to execute method
  def menu(run_method)
    header
    instruct_input_targets("fqdn", "ip", "ipr", "iprl", "iprf", "cidr")
    a = File.open(@stdn_hosts, "w")
    while line = gets
      a << line
    end
    a.close
    stdn_hosts = @stdn_hosts
    line_count = `wc -l #{stdn_hosts}`.to_i
    if line_count == 0
      puts "No hosts were input.".red
      menu(run_method)
    else
      execute(run_method)
    end
  rescue Interrupt
    GExeption.new.exit_weapon("Nmap", @prev_menu)
  end

  # Parse and exit
  def clean_exit(run_method)
    puts
    out_xml_file = @out_file + ".xml"
    if File.exist?(out_xml_file)
      puts "Nmap output files are here:".light_yellow
      puts @out_file + ".gnmap"
      puts @out_file + ".nmap"
      puts out_xml_file
      unless run_method.include? "script_"
        NmapParser.new(@prev_menu, out_xml_file).open_ports_csv
      end
    end
    exit_weapon
  end

###############################################################################
# Execution methods
###############################################################################
# Execute run methods
  def execute(run_method)
    @out_file = get_out_file(@name)
    prependix = @path + " -v -Pn -s"
    appendix = " -iL " + @stdn_hosts + " -oA " + @out_file
      case run_method
      when "custom" then custom
        cmd = @cmd
# ttd_2: arp/icmp ping: parse up hosts
      when "ping_discovery" then cmd = @path + \
        " -v -T4 -sn --min-hostgroup 256 -iL " + @stdn_hosts + " -oA " + @out_file
      when "script_ftp_anon" then cmd = prependix + \
        "S -p21 --script ftp-anon" + appendix
      when "script_http_methods" then cmd = prependix + \
        "S -p80,443 --script http-methods" + appendix
      when "script_smtp_open_relay" then cmd = prependix + \
        "S -p25,465,587 --script smtp-open-relay" + appendix
      when "script_snmp_dictionary" then cmd = prependix + \
        "U -p161 --script snmp-brute --script-args snmp-brute.communitiesdb=" + @snmp_comm_strings_long + appendix
      when "script_tftp_files" then cmd = prependix + \
        "U -p69 --script tftp-enum" + appendix
      when "tcp_full" then cmd = prependix + \
        "S -T4 --min-hostgroup 128 -p1-65535" + appendix
      when "tcp_quick_scripts" then cmd = prependix + \
        "SV -T4 --script all --min-hostgroup 128" + appendix
      when "tcp_quick" then cmd = prependix + \
        "S -T4 --min-hostgroup 128" + appendix
      when "tcp_udp_full" then cmd = prependix + \
        "SU -T4 --min-hostgroup 128 -p1-65535" + appendix
      when "tcp_udp_quick_scripts" then cmd = prependix + \
        "SUV -Pn --script=all --min-hostgroup 128" + appendix
      when "tcp_udp_quick" then cmd = prependix + \
        "SU -T4 --min-hostgroup 128" + appendix
      when "tcp_very_quick_lan" then cmd = prependix + \
        "S -T5 --top-ports 25 --min-hostgroup 256" + appendix
      when "tcp_very_quick_wan" then cmd = prependix + \
        "S -T4 --top-ports 25 --min-hostgroup 256" + appendix
      when "udp_full" then cmd = prependix + \
        "U -T4 --min-hostgroup 128 -p1-65535" + appendix
      when "udp_quick_scripts" then cmd = prependix + \
        "UV -T4 --script=all --min-hostgroup 128" + appendix
      when "udp_quick" then cmd = prependix + \
        "U -T4 --min-hostgroup 128" + appendix
      end
    run(cmd)
    clean_exit(run_method)
  end

  # Custom scan
  def custom
    puts "Input your custom arguments and hit <Enter>:".light_yellow
    puts "Note: Gladius will add -v and I/O paths.".yellow
    puts "Examples:".yellow
    puts "-sUV -Pn -p21-23,25,80,161".yellow
    puts "-A -T4 -sSV -Pn -p22,2222".yellow
    puts
    args = gets.chomp
    @cmd = @path + " -v #{args} -iL " + @stdn_hosts + " -oA " + @out_file
  end
end  
