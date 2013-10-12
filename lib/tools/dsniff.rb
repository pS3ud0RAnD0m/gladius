#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require_relative 'tool'
require_relative 'gpty'

class Dsniff < Tool
  def initialize(title)
    @title = title
    # Path variables
    @@path = "dsniff"
    # Variables for timestamping out files and child pid files
    @@time = Time.now
    @@out_file_tstamp = @@time.year.to_s + "-" + @@time.mon.to_s + "-" + @@time.day.to_s + \
                  "_" + @@time.hour.to_s + ":" + @@time.min.to_s + ":" + @@time.sec.to_s
    @@out_file = "/usr/share/gladius/output/dsniff_" + @@out_file_tstamp + ".txt"
    @@pid_tstamp = "%10.10f" % @@time.to_f
    @@pid_file = "/usr/share/gladius/tmp/pids/" + @@pid_tstamp
  end

  def header_dsniff
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
  end

  def clean_exit
    if File.exists?(@@pid_file)
      pid = File.read(@@pid_file)
      `kill -9 #{pid}`
      File.delete(@@pid_file)
    end
    results
    puts
    SniffSpoof.new("Sniffing and Spoofing").menu
  rescue Interrupt
    puts
    puts "Exiting Gladius. Have a bloody day!".red
    begin
      Kernel.exit
    rescue Exception => e
    puts
    end
  end
  
  # Rescue mid-attack 
  def resc
    puts
    puts "Sniffing stopped due to interrupt.".red
    clean_exit
  end
  
  # Parse and display results
  def results
    puts
    out_file = @@out_file
# ttd: account for ANYTHING in the outfile
    rslt = open(@@out_file) { |a| a.grep(/PASS|USER|\//) }
    if rslt.count == 0
      puts "Dsniff did not find any credentials.".light_yellow
    else
      puts "Dsniff found the following credentials:".light_yellow
      puts rslt
      puts
      puts "Raw output can be found here:".yellow
      puts out_file
    end
  end
  
  # Sniff for plaintext creds against all supported protocols
  def all
    header_dsniff
    puts
    x = Gpty.new
    x.time = @@pid_tstamp
    x.cmd = @@path + " -m -n -i any |tee " + @@out_file
    x.shell
    puts
    clean_exit
  rescue Interrupt
    resc
  end
end  
