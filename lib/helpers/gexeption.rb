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
# ttd_1: add all menus to this list
      when "DictionaryOnline" then DictionaryOnline.new("Online Dictionary Attacks").menu
      when "DiscoverServices" then DiscoverServices.new("Discover Services").menu
      when "DNS" then DNS.new("Gather Information - DNS").menu
      when "FTP" then FTP.new("Gather Information - FTP").menu
      when "HTTP" then HTTP.new("HTTP(S)").menu
      when "KaliSupport" then KaliSupport.new("Configure Kali Services").menu
      when "ParseFile" then ParseFile.new("Parse Files").menu
      when "SniffSpoof" then SniffSpoof.new("Sniffing and Spoofing").menu
      when "SNMP" then SNMP.new("SNMP").menu
      when "SMTP" then SMTP.new("Gather Information - SMTP").menu
      when "TFTP" then TFTP.new("Gather Information - TFTP").menu
    end
  rescue Interrupt
    exit_gladius
  end
end