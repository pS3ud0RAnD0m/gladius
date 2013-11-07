# Author: p$3ud0R@nD0m

class GNmap < Weapon
  def initialize(prev_menu, title)
    @prev_menu = prev_menu
    @title = title
    @path = "nmap"
    @name = @path
    @stdn_hosts = Path.get_path("stdn_hosts")
    @snmp_comm_strings_long = Path.get_path("snmp_comm_strings_long")
  end

###############################################################################
# DRY methods
###############################################################################
  # Get target(s) and pass to relevant run method
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
      case run_method
        # Pass discovery scans
        when "ping_discovery" then ping_discovery
        when "tcp_very_quick_lan" then tcp_very_quick_lan
        when "tcp_very_quick_wan" then tcp_very_quick_wan
        when "tcp_quick" then tcp_quick
        when "udp_quick" then udp_quick
        when "tcp_udp_quick" then tcp_udp_quick
        when "tcp_quick_scripts" then tcp_quick_scripts
        when "udp_quick_scripts" then udp_quick_scripts
        when "tcp_udp_quick_scripts" then tcp_udp_quick_scripts
        when "tcp_full" then tcp_full
        when "udp_full" then udp_full
        when "tcp_udp_full" then tcp_udp_full
        when "custom" then custom
        # Pass script scans
        when "script_ftp_anon" then script_ftp_anon
        when "script_http_methods" then script_http_methods
        when "script_snmp_dictionary" then script_snmp_dictionary
        when "script_smtp_open_relay" then script_smtp_open_relay
        when "script_tftp_files" then script_tftp_files
      end
    end
  rescue Interrupt
    GExeption.new.exit_weapon("Nmap", @prev_menu)
  end

  # Parse and exit
  def clean_exit
    puts
    out_xml_file = @out_file + ".xml"
    if File.exist?(out_xml_file)
      puts "Nmap output files are here:".light_yellow
      puts @out_file + ".gnmap"
      puts @out_file + ".nmap"
      puts out_xml_file
      NmapParser.new(@prev_menu, out_xml_file).open_ports_csv
    end
    exit_weapon
  end

###############################################################################
# Run methods
###############################################################################
  # Scan ARP/ICMP discovery
# ttd_2: arp/icmp ping: parse up hosts
  def ping_discovery
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sn --min-hostgroup 256 -iL " + @stdn_hosts + " -oA " + @out_file
    run(cmd)
    clean_exit
  end
  
  # Scan top 25 tcp ports on LAN
  def tcp_very_quick_lan
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T5 -Pn -sS --top-ports 25 --min-hostgroup 256 -iL " + @stdn_hosts + " -oA " + @out_file
    run(cmd)
    clean_exit
  end

  # Scan top 25 tcp ports on WAN
  def tcp_very_quick_wan
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -Pn -sS --top-ports 25 --min-hostgroup 256 -iL " + @stdn_hosts + " -oA " + @out_file
    run(cmd)
    clean_exit
  end
  
  # Scan top 1000 tcp ports
  def tcp_quick
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sS -Pn --min-hostgroup 128 -iL " + @stdn_hosts + " -oA " + @out_file
    run(cmd)
    clean_exit
  end
  
  # Scan top 1000 tcp ports with scripts
  def tcp_quick_scripts
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sSV -Pn --script=all --min-hostgroup 128 -iL " + @stdn_hosts + " -oA " + @out_file
    run(cmd)
    clean_exit
  end

  # Scan all tcp ports
  def tcp_full
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sS -Pn --min-hostgroup 128 -p1-65535 -iL " + @stdn_hosts + " -oA " + @out_file
    run(cmd)
    clean_exit
  end

  # Scan top 1000 udp ports
  def udp_quick
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sU -Pn --min-hostgroup 128 -iL " + @stdn_hosts + " -oA " + @out_file
    run(cmd)
    clean_exit
  end
  
  # Scan top 1000 udp ports with scripts
  def udp_quick_scripts
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sUV -Pn --script=all --min-hostgroup 128 -iL " + @stdn_hosts + " -oA " + @out_file
    run(cmd)
    clean_exit
  end

  # Scan all udp ports
  def udp_full
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sU -Pn --min-hostgroup 128 -p1-65535 -iL " + @stdn_hosts + " -oA " + @out_file
    run(cmd)
    clean_exit
  end
 
  # Scan top 1000 tcp/udp ports
  def tcp_udp_quick
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sSU -Pn --min-hostgroup 128 -iL " + @stdn_hosts + " -oA " + @out_file
    run(cmd)
    clean_exit
  end
  
  # Scan top 1000 tcp/udp ports with scripts
  def tcp_udp_quick_scripts
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sSUV -Pn --script=all --min-hostgroup 128 -iL " + @stdn_hosts + " -oA " + @out_file
    run(cmd)
    clean_exit
  end

  # Scan all tcp/udp ports
  def tcp_udp_full
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sSU -Pn --min-hostgroup 128 -p1-65535 -iL " + @stdn_hosts + " -oA " + @out_file
    run(cmd)
    clean_exit
  end
  
  # Custom scan
  def custom
    puts "Input your custom arguments and hit <Enter>:".light_yellow
    puts "Note: Do not include -v or input/output paths.".yellow
    puts "Examples:".yellow
    puts "-sUV -Pn -p161".yellow
    puts "-A -T4 -sSV -Pn -p22".yellow
    puts
    args = gets.chomp
    @out_file = get_out_file(@name)
    cmd = @path + " -v #{args} -iL " + @stdn_hosts + " -oA " + @out_file
    run(cmd)
    clean_exit
  end

###############################################################################
# Script scans
###############################################################################
# ttd_2: parse these scripts better
  # Discover anonymous ftp
  def script_ftp_anon
    @out_file = get_out_file(@name)
    cmd = @path + " -v -Pn -sS -p21 --script=ftp-anon -iL " + @stdn_hosts + " -oA " + @out_file
    run(cmd)
    clean_exit
  end

# ttd_2: HTTP method: Ask for ports
  # Discover enabled http methods
  def script_http_methods
    @out_file = get_out_file(@name)
    cmd = @path + " -v -Pn -sS -p80,443 --script=http-methods -iL " + @stdn_hosts + " -oA " + @out_file
    run(cmd)
    clean_exit
  end

  # Dictionary attack snmp
  def script_snmp_dictionary
    @out_file = get_out_file(@name)
    cmd = @path + " -v -Pn -sU -p161 --script=snmp-brute --script-args snmp-brute.communitiesdb=" + @snmp_comm_strings_long + " -iL " + @stdn_hosts + " -oA " + @out_file
    run(cmd)
    clean_exit
  end
  
  # Discover smtp open relay
  def script_smtp_open_relay
    @out_file = get_out_file(@name)
    cmd = @path + " -v -Pn -sS -p25,465,587 --script=smtp-open-relay -iL " + @stdn_hosts + " -oA " + @out_file
    run(cmd)
    clean_exit
  end

  # Discover tftp files
  def script_tftp_files
    @out_file = get_out_file(@name)
    cmd = @path + " -v -Pn -sU -p69 --script=tftp-enum -iL " + @stdn_hosts + " -oA " + @out_file
    run(cmd)
    clean_exit
  end
end  
