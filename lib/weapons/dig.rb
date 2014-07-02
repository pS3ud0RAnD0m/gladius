# Author: p$3ud0R@nD0m

class DiG < Weapon
  def initialize(prev_menu, title)
    # Common
    @name = self.class.to_s.downcase
    @path = @name
    @prev_menu = prev_menu
    @stdin_hosts = Path.get("share_stdin_hosts")
    @title = title
  end

###############################################################################
# DRY methods
###############################################################################
  # Dry menu
  def menu(run_method)
    header
    case run_method
    when "idcontrollers" then idcontrollers
    end
  rescue Interrupt
    GExeption.new.exit_weapon("DiG", @prev_menu)
  end

  # Exit
  def clean_exit
    exit_weapon
  end

###############################################################################
# Run methods
###############################################################################
  # Identify Domain Controllers, i.e., servers running kerb.
  def idcontrollers
    # Get dns server
    dns_server = `nslookup server |grep Server |awk '{print $2}'`.chomp
    puts "Gladius identified the following DNS server for Kerberos enumeration: #{dns_server}".yellow
    puts "Hit <Enter> to continue or input another DNS server IP:".light_yellow
    stdin_dns_server = gets.chomp
    # Get domain
    domain = `cat /etc/resolv.conf |grep domain |awk '{print $2}'`.chomp
    unless domain.empty?
      puts "Gladius identified the following domain for Kerberos enumeration: #{domain}".yellow
      puts "Hit <Enter> to continue or input another domain:".light_yellow
      stdin_domain = gets.chomp
    else
      until !domain.empty? do
         puts "Gladius was not able to identify your current domain. Input target domain:".light_yellow
         stdin_domain = gets.chomp
      end
    end
    # Identify kerb services via dig against DNS server
    unless stdin_dns_server.empty?
      unless stdin_domain.empty?
        cmd = @path + " @" + stdin_dns_server + " SRV _kerberos._tcp.dc._msdcs." + stdin_domain
        run(cmd)
      else
        cmd = @path + " @" + stdin_dns_server + " SRV _kerberos._tcp.dc._msdcs." + domain
        run(cmd)
      end
    else
      unless stdin_domain.empty?
        cmd = @path + " @" + dns_server + " SRV _kerberos._tcp.dc._msdcs." + stdin_domain
        run(cmd)
      else
        cmd = @path + " @" + dns_server + " SRV _kerberos._tcp.dc._msdcs." + domain
        run(cmd)
      end
    end
    clean_exit
  end
end
