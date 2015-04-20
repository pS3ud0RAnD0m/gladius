# Author: p$3ud0R@nD0m

class DNS < Menu
  def menu
    header
    puts "Select an option:".light_yellow
    puts "1.  Identify Domain Controllers (DiG)"
    puts "2.  Attempt a zone transfer (DNSrecon)"
    puts "3.  Attempt a zone transfer and enum standard records (DNSrecon)"
    puts "4.  Attempt a zone transfer and dictionary attack records (Fierce)"
    puts "5.  Perform Google search for sub-domains and hosts (DNSrecon)"
    puts "6.  Perform reverse lookups for an IP block (DNSrecon)"
    puts "88. Back"
    puts "99. Exit Gladius"
    
    selection = gets.to_i
    case selection
    when 1 then DiG.new("DNS", "DiG - Identify Domain Controllers").menu("idcontrollers")
    when 2 then DNSrecon.new("DNS", "DNSrecon - Zone Transfer").menu("transfer")
    when 3 then DNSrecon.new("DNS", "DNSrecon - Zone Transfer or Lookup Standard Records").menu("standard")
    when 4 then Fierce.new("DNS", "Fierce - Zone Transfer or Brute Force Records").menu("dictionary")
    when 5 then DNSrecon.new("DNS", "DNSrecon - Google Search for Sub-domains and Hosts").menu("google")
    when 6 then DNSrecon.new("DNS", "DNSrecon - Reverse Lookups").menu("reverse")
    when 88 then GatherInfo.new("Information Gathering").menu
    when 99 then GExeption.new.exit_gladius
    else puts "Invalid selection.".red
      menu
    end
  end
end
