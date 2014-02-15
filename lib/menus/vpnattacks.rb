# Author: p$3ud0R@nD0m

require_relative 'menu'

class VPNAttacks < Menu
  def menu
    header
    puts "Select a category:".light_yellow
    puts "1.  Aggressive IKE - grab and crack hash (NI)"
    puts "88. Back"
    puts "99. Exit Gladius"
    
    selection = gets.to_i
    case selection
    when 1 then puts "Not implemented yet.".red
      menu
    when 88 then NetworkAttacks.new("Network Attacks").menu
    when 99 then GExeption.new.exit_gladius
    else puts "Invalid selection.".red
      menu
    end
  end
end
