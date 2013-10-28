# Author: p$3ud0R@nD0m

class NetworkAttacks < Menu
  def menu
    header
    puts "Select a category:".light_yellow
    puts "1.  Sniffing and Spoofing"
    puts "2.  VPN attacks"
    puts "88. Back"
    puts "99. Exit Gladius"
    sel = gets.to_i
    case sel
      when 1 then SniffSpoof.new("Sniffing and Spoofing").menu
      when 2 then VPNAttacks.new("VPN Attacks").menu
      when 4 then puts "Not implemented yet.".red
        menu
      when 88 then Home.new.menu
      when 99 then GExeption.new.exit_gladius
      else puts "Invalid selection.".red
        puts
        menu
    end
  end
end
