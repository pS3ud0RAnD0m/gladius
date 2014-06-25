# Author: p$3ud0R@nD0m

class Dsniff < Weapon
  def initialize(prev_menu, title)
    # Common
    @name = self.class.to_s.downcase
    @path = @name
    @prev_menu = prev_menu
    @title = title
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
    puts "Note: This weapon isn't displaying harvested FTP or Telnet credentials until the sniffed connection is terminated.".yellow
    puts "When done sniffing, press Ctrl+C.".light_yellow
    case scan_type
    when "all" then all
    end
  end

  # Exit
  def clean_exit
    if File.exist?(@out_file)
      puts "Raw output can be found here:".yellow
      puts @out_file
    end
    exit_weapon
  end
  
###############################################################################
# Run methods
###############################################################################
  # Sniff for plaintext creds against all supported protocols
  def all
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -m -n -i any |tee " + @out_file
    run(cmd)
    services = Dir.pwd + "/dsniff.services"
    if File.exists?(services)
      FileUtils.rm(services)
    end
    clean_exit
  end
end  
