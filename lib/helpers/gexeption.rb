# Author: p$3ud0R@nD0m

# ttd_2: Ensure all interrupts are using this class.
class GExeption
  # log exception
  def log
  end
  
  # Rescue to home
  def home
    Home.new.menu
  end
  
  # Cleanly exit gladius
  def exit_gladius
    puts
    puts "Exiting Gladius. Have a bloody day!".red
    begin
      Kernel.exit
    rescue Exception => e
      puts
    end
  end

  # Rescue to previous menu
  def exit_weapon(weapon, back)
    puts
    puts "Exiting #{weapon}.".red
    case back
       when "Dictionary" then Dictionary.new("Dictionary Attacks").menu
       when "DictionaryOnline" then DictionaryOnline.new("Online Dictionary Attacks").menu
       when "DiscoverServices" then DiscoverServices.new("Nmap - Discover Services").menu
       when "DNS" then DNS.new("Gather Information - DNS").menu
       when "FTP" then FTP.new("Gather Information - FTP").menu
       when "GatherInfo" then GatherInfo.new("Gather Information").menu
       when "HTTP" then HTTP.new("Gather Information - HTTP(S)").menu
       when "KaliSupport" then KaliSupport.new("Kali Support").menu
       when "NetbiosSMB" then NetbiosSMB.new("Gather Information - Netbios-SMB").menu
       when "NetworkAttacks" then NetworkAttacks.new("Network Attacks").menu
       when "ParseFile" then ParseFile.new("Parse Files").menu
       when "SMTP" then SMTP.new("Gather Information - SMTP").menu
       when "SniffSpoof" then SniffSpoof.new("Sniffing and Spoofing").menu
       when "SNMP" then SNMP.new("Gather Information - SNMP").menu
       when "SnortService" then SnortService.new("Upgrade/Install Snort/Snorby and Start").install
       when "TFTP" then TFTP.new("Gather Information - TFTP").menu
       when "VPNAttacks" then VPNAttacks.new("VPN Attacks").menu
    end
  rescue Interrupt
    exit_gladius
  end
end