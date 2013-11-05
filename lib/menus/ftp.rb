# Author: p$3ud0R@nD0m

require_relative 'menu'

class FTP < Menu
  def menu
    header
    puts "Select an option:".light_yellow
    puts "1.  Discover anonymous FTP read/write logins (Nmap)"
    puts "88. Back"
    puts "99. Exit Gladius"
    selection = gets.to_i
    case selection
      when 1 then GNmap.new("FTP", "Nmap - Anonymous FTP").menu("script_ftp_anon")
      when 88 then GatherInfo.new("Information Gathering").menu
      when 99 then GExeption.new.exit_gladius
      else puts "Invalid selection.".red
        menu
    end
  end
end
