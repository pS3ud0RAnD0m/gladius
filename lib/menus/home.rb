# Author: p$3ud0R@nD0m

class Home
  def header_home
    puts "------------------------------"
    puts "Home                 v0.0.2.14"
    puts "------------------------------"
  end

  def menu
    header_home
    puts "Select a category:".light_yellow
    puts "1.  Gather information"
    puts "2.  Network attacks"
    puts "3.  Web attacks (NI)".blue
    puts "4.  Wireless attacks (NI)".blue
    puts "5.  Dictionary attacks"
    puts "6.  Kali support"
    puts "99. Exit Gladius"
    
    selection = gets.to_i
    case selection
    when 1 then GatherInfo.new("Gather Information").menu
    when 2 then NetworkAttacks.new("Network Attacks").menu
    when 3 then puts "Not implemented yet.".red
      menu
    when 4 then puts "Not implemented yet.".red
      menu
    when 5 then Dictionary.new("Dictionary Attacks").menu
    when 6 then KaliSupport.new("Kali Support").menu
    when 99 then GExeption.new.exit_gladius
    else puts "Invalid selection.".red
      menu
    end
  end
end
