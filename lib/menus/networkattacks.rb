# Author: p$3ud0R@nD0m

class NetworkAttacks < Menu
  def menu
    header
    puts "Select a tactic:".light_yellow
    puts "1.  Sniffing and spoofing"
    puts "2.  Socket fuzzing"
    puts "3.  VPN attacks (NI)".blue
    puts "88. Back"
    puts "99. Exit Gladius"
    
    selection = gets.to_i
    case selection
    when 1 then SniffSpoof.new("Sniffing and Spoofing").menu
    when 2 then SocketFuzz.new("Socket Fuzzing").menu
    when 3 then VPNAttacks.new("VPN Attacks").menu
    when 4 then puts "Not implemented yet.".red
      menu
    when 88 then Home.new.menu
    when 99 then GExeption.new.exit_gladius
    else puts "Invalid selection.".red
      menu
    end
  end
end
