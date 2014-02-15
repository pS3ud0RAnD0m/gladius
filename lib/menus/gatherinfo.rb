# Author: p$3ud0R@nD0m

class GatherInfo < Menu
  def menu
    header
    puts "Select a service to target:".light_yellow
    puts "1.  Discover services (Nmap)"
    puts "2.  DNS"
    puts "3.  FTP"
    puts "4.  HTTP(S)"
    puts "5.  MSSQL (NI)"
    puts "6.  MySQL (NI)"
    puts "7.  Netbios-SMB (NI)"
    puts "8.  Oracle (NI)"
    puts "9.  RDP (NI)"
    puts "10. SMTP"
    puts "11. SNMP"
    puts "12. SSH (NI)"
    puts "13. Telnet (NI)"
    puts "14. TFTP"
    puts "88. Back"
    puts "99. Exit Gladius"
    
    selection = gets.to_i
    case selection
    when 1 then DiscoverServices.new("Nmap - Discover Services").menu
    when 2 then DNS.new("Gather Information - DNS").menu
    when 3 then FTP.new("Gather Information - FTP").menu
    when 4 then HTTP.new("Gather Information - HTTP(S)").menu
    when 5 then puts "Not implemented yet.".red
      menu
    when 6 then puts "Not implemented yet.".red
      menu
    when 7 then NetbiosSMB.new("Gather Information - Netbios-SMB").menu
    when 8 then puts "Not implemented yet.".red
      menu
    when 9 then puts "Not implemented yet.".red
      menu
    when 10 then SMTP.new("Gather Information - SMTP").menu
    when 11 then SNMP.new("Gather Information - SNMP").menu
    when 12 then  puts "Not implemented yet.".red
      menu
    when 13 then puts "Not implemented yet.".red
      menu
    when 14 then TFTP.new("Gather Information - TFTP").menu
    when 88 then Home.new.menu
    when 99 then GExeption.new.exit_gladius
    else puts "Invalid selection.".red
      menu
    end
  end
end
