#!/usr/bin/env ruby

# Author: p$3ud0R@nD0m

class Dsniff < Tool
  def initialize(prev_menu, title)
    @prev_menu = prev_menu
    @title = title
    @path = "dsniff"
    @name = @path
  end

###############################################################################
# DRY methods
###############################################################################
  # List supported protocols and exit instructions, then pass to relevant sniff method
  def menu(scan_type)
    header
    puts "Sniffing for plaintext credentials on the following ports:".light_yellow
    puts "AIM           5190,9898/tcp".yellow
    puts "Citrix        1494/tcp".yellow
    puts "CVS           2401/tcp".yellow
    puts "FTP           21/tcp".yellow
    puts "HTTP          80,98,3128,8080/tcp".yellow
    puts "ICQ           4000/udp".yellow
    puts "IMAP          143,220/tcp".yellow
    puts "IRC           6667-9/tcp".yellow
    puts "LDAP          389/tcp".yellow
    puts "MMXP          417,2417/tcp/udp".yellow
    puts "Mountd        100005/rpc".yellow
    puts "Napster       4444,5555,6666,7777,8888/tcp".yellow
    puts "NNTP          119/tcp".yellow
    puts "Oracle        1521,1526/tcp".yellow
    puts "OSPF          89/ip".yellow
    puts "PCAnywhere    5631,65301/tcp".yellow
    puts "POP2          109/tcp".yellow
    puts "POP3          110/tcp".yellow
    puts "POPpass       106/tcp".yellow
    puts "Portmap       -111,111/tcp/udp".yellow
    puts "PostGreSQL    5432/tcp".yellow
    puts "PPTP          47/ip".yellow
    puts "RIP           520/udp".yellow
    puts "Rlogin        512-514/tcp".yellow
    puts "SMB           139/tcp".yellow
    puts "SMTP          25/tcp".yellow
    puts "SMTP          587/tcp".yellow
    puts "Sniffer       2001/udp".yellow
    puts "SNMP          161/udp".yellow
    puts "SOCKS         1080/tcp".yellow
    puts "TDS           1433,2638,7599/tcp".yellow
    puts "TDS           1433/udp".yellow
    puts "Telnet        23,261/tcp".yellow
    puts "VRRP          112/ip".yellow
    puts "X11           6000-6005/tcp".yellow
    puts "YPPasswd      100009/rpc".yellow
    puts "YPServ        100004/rpc".yellow
    puts
    puts "Note: This tool isn't displaying harvested FTP or Telnet credentials until the sniffed connection is terminated.".yellow
    puts "When done sniffing, press <Ctrl+c>.".light_yellow
    case scan_type
      when "all" then all
    end
  end

  # Parse and exit
  def clean_exit
    puts
    out_file = @out_file
# ttd_1: account for ANYTHING in the outfile
    rslt = open(@out_file) { |a| a.grep(/PASS|USER|\//) }
    if rslt.count == 0
      puts "Dsniff did not find any credentials.".light_yellow
    else
      puts "Dsniff found the following credentials:".light_yellow
      puts rslt
      puts
      puts "Raw output can be found here:".yellow
      puts @out_file
    end
    puts
    case @prev_menu
      when "SniffSpoof" then SniffSpoof.new("Sniffing and Spoofing").menu
    end
  rescue Interrupt
    GExeption.new.exit_gladius
  end
  
###############################################################################
# Sniff methods
###############################################################################
  # Sniff for plaintext creds against all supported protocols
  def all
    @out_file = get_out_file_txt(@name)
    cmd = @path + " -m -n -i any |tee " + @out_file
    run(cmd)
    clean_exit
  end
end  
