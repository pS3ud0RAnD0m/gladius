# Author:  p$3ud0R@nD0m

require_relative 'menu'

class TFTP < Menu
  def menu
    header
    puts "Select an option:".light_yellow
    puts "1.  Discover TFTP files (Nmap)"
    puts "88. Back"
    puts "99. Exit Gladius"
    
    selection = gets.to_i
    case selection
    when 1 then GNmap.new("TFTP", "Nmap - Discover TFTP Files").menu("script_tftp_files")
    when 88 then GatherInfo.new("Information Gathering").menu
    when 99 then GExeption.new.exit_gladius
    else puts "Invalid selection.".red
      menu
    end
  end
end
