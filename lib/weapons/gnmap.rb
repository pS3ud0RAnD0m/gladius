# Author: p$3ud0R@nD0m

class GNmap < Weapon
  def initialize(prev_menu, title)
    # Common
    @prev_menu = prev_menu
    @title = title
    @stdin_hosts = Path.get("share_stdin_hosts")
    # Weapon specific
    @cmd = ""
    @name = "nmap"
    @path = @name
    # Weapon specific lists
    @snmp_comm_strings_long = Path.get("snmp_comm_strings_long")
    @tftp_file_list = Path.get("tftp_file_list")
  end

###############################################################################
# User interaction methods
###############################################################################
  # Get target(s) and pass to execute method
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
    if line_count == 0
      no_input
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
        NmapParser.new(@prev_menu, out_xml_file).all_to_csv
      end
    end
    exit_weapon
  end

###############################################################################
# Execution methods
###############################################################################
# Execute method
  def execute(run_method)
    @out_file = Path.get_out_file(@name)
    cmd_prefix = "#{@path} -v"
    cmd_suffix = "-iL #{@stdin_hosts} -oA #{@out_file}"
    case run_method
    when "custom" then custom
      cmd = @cmd
    when "ping_discovery"         then cmd_infix = "-sn"
    when "script_ftp_anon"        then cmd_infix = "-Pn -sS -p21 --script ftp-anon"
    when "script_http_methods"    then cmd_infix = "-Pn -sS -p80,443 --script http-methods"
    when "script_smtp_open_relay" then cmd_infix = "-Pn -sS -p25,465,587 --script smtp-open-relay"
    when "script_snmp_dictionary" then cmd_infix = "-Pn -sU -p161 --script snmp-brute --script-args snmp-brute.communitiesdb=#{@snmp_comm_strings_long}"
    when "script_tftp_files"      then cmd_infix = "-Pn -sU -p69 --script tftp-enum"
    when "tcp_full"               then cmd_infix = "-Pn -sS -p0-65535 -T4 --min-hostgroup 128"
    when "tcp_quick_scripts"      then cmd_infix = "-Pn -sSV -T4 --script all --min-hostgroup 128"
    when "tcp_quick"              then cmd_infix = "-Pn -sS -T4 --min-hostgroup 128"
    when "tcp_quick_v"            then cmd_infix = "-Pn -sSV -T4 --min-hostgroup 128"
    when "tcp_udp_full"           then cmd_infix = "-Pn -sSU -p0-65535 -T4 --min-hostgroup 128"
    when "tcp_udp_quick_scripts"  then cmd_infix = "-Pn -sSUV -Pn --script=all --min-hostgroup 128"
    when "tcp_udp_quick"          then cmd_infix = "-Pn -sSU -T4 --min-hostgroup 128"
    when "tcp_udp_quick_v"        then cmd_infix = "-Pn -sSUV -T4 --min-hostgroup 128"
    when "tcp_very_quick_lan"     then cmd_infix = "-Pn -sS --top-ports 25 -T5 --min-hostgroup 256"
    when "tcp_very_quick_wan"     then cmd_infix = "-Pn -sS --top-ports 25 -T4 --min-hostgroup 256"
    when "udp_full"               then cmd_infix = "-Pn -sU -p0-65535 -T4 --min-hostgroup 128"
    when "udp_quick_scripts"      then cmd_infix = "-Pn -sUV -T4 --script=all --min-hostgroup 128"
    when "udp_quick"              then cmd_infix = "-Pn -sU -T4 --min-hostgroup 128"
    when "udp_quick_v"            then cmd_infix = "-Pn -sUV -T4 --min-hostgroup 128"
    end
    cmd = "#{cmd_prefix} #{cmd_infix} #{cmd_suffix}"
    run(cmd)
    clean_exit(run_method)
  end

  # Custom scan
  def custom
    puts "Input your custom arguments and hit <Enter>:".light_yellow
    puts "Note: Gladius will add -v and I/O paths.".yellow
    puts "Examples:".yellow
    puts "-Pn -sSUV -p21-23,25,80,161".yellow
    puts "-Pn -sSV -T4 -A -p22,2222".yellow
    puts
    args = gets.chomp
    @cmd = "#{args}"
  end
end  
