#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

class GNmap < Tool
  def initialize(title)
    @title = title
    @path = "nmap"
    @name = @path
    @hosts_file = Path.hosts_file
  end

  # Get target(s) and pass to relevant scan method
  def menu(scan_type)
    header
    instruct_input_targets("fqdn", "ip", "ipr", "iprl", "iprf", "cidr")
    a = File.open(@hosts_file, "w")
    while line = gets
      a << line
    end
    a.close
    hosts = @hosts_file
    line_count = `wc -l #{hosts} |awk '{print $1}'`.to_i
    if line_count == 0
      puts "No hosts were input.".red
      menu
    else
      case scan_type
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
      end
    end
  rescue Interrupt
    GExeption.new.exit_tool("Nmap", "DiscoverServices")
  end

  # Parse and exit
  def clean_exit
    @out_xml_file = @out_file + ".xml"
    puts
    puts "Nmap output files are here:".light_yellow
    puts @out_file + ".gnmap"
    puts @out_file + ".nmap"
    puts @out_xml_file
    begin
      NmapParser.new(@out_xml_file).open_ports
      puts "Summary output has been parsed and put here:".light_yellow
      puts @out_xml_file + ".gladius"
    rescue Exception => e
    end
    puts
    DiscoverServices.new("Discover Services").menu
  rescue Interrupt
    GExeption.new.exit_gladius
  end
  
  # Scan top 25 tcp ports on LAN
  def tcp_very_quick_lan
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T5 -Pn -sS --top-ports 25 --min-hostgroup 256 -iL " + @hosts_file + " -oA " + @out_file
    run(cmd)
    clean_exit
  end

  # Scan top 25 tcp ports on WAN
  def tcp_very_quick_wan
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -Pn -sS --top-ports 25 --min-hostgroup 256 -iL " + @hosts_file + " -oA " + @out_file
    run(cmd)
    clean_exit
  end
  
  # Scan top 1000 tcp ports
  def tcp_quick
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sS -Pn --min-hostgroup 128 -iL " + @hosts_file + " -oA " + @out_file
    run(cmd)
    clean_exit
  end
  
  # Scan top 1000 tcp ports with scripts
  def tcp_quick_scripts
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sSV -Pn --script=all --min-hostgroup 128 -iL " + @hosts_file + " -oA " + @out_file
    run(cmd)
    clean_exit
  end

  # Scan all tcp ports
  def tcp_full
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sS -Pn --min-hostgroup 128 -p1-65535 -iL " + @hosts_file + " -oA " + @out_file
    run(cmd)
    clean_exit
  end

  # Scan top 1000 udp ports
  def udp_quick
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sU -Pn --min-hostgroup 128 -iL " + @hosts_file + " -oA " + @out_file
    run(cmd)
    clean_exit
  end
  
  # Scan top 1000 udp ports with scripts
  def udp_quick_scripts
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sUV -Pn --script=all --min-hostgroup 128 -iL " + @hosts_file + " -oA " + @out_file
    run(cmd)
    clean_exit
  end

  # Scan all udp ports
  def udp_full
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sU -Pn --min-hostgroup 128 -p1-65535 -iL " + @hosts_file + " -oA " + @out_file
    run(cmd)
    clean_exit
  end
 
  # Scan top 1000 tcp/udp ports
  def tcp_udp_quick
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sSU -Pn --min-hostgroup 128 -iL " + @hosts_file + " -oA " + @out_file
    run(cmd)
    clean_exit
  end
  
  # Scan top 1000 tcp/udp ports with scripts
  def tcp_udp_quick_scripts
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sSUV -Pn --script=all --min-hostgroup 128 -iL " + @hosts_file + " -oA " + @out_file
    run(cmd)
    clean_exit
  end

  # Scan all tcp/udp ports
  def tcp_udp_full
    @out_file = get_out_file(@name)
    cmd = @path + " -v -T4 -sSU -Pn --min-hostgroup 128 -p1-65535 -iL " + @hosts_file + " -oA " + @out_file
    run(cmd)
    clean_exit
  end
  
  # Custom scan
  def custom
    puts "Input your custom arguments and hit <Enter>:".light_yellow
    puts "Examples:".yellow
    puts "-v -sUV -Pn -p161".yellow
    puts "-v -A -T4 -sSV -Pn -p22".yellow
    puts
    args = gets.chomp
    @out_file = get_out_file(@name)
    cmd = @path + " #{args} -iL " + @hosts_file + " -oA " + @out_file
    run(cmd)
    clean_exit
  end
end  
