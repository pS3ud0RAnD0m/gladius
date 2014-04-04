# Author: p$3ud0R@nD0m

require_relative 'menu'

class KaliSupport < Menu
  def menu
    header
    puts "Select a task:".light_yellow
    puts "1.  Files - Parse (Gladius)"
    puts "2.  Firewall - List rules (IPtables)"
    puts "3.  Firewall - Configure (IPtables)"
    puts "4.  Server - Setup a TFTP server (atftpd)"
    puts "5.  Server - Setup an FTP server (NI)".blue
    puts "6.  Server - Setup an HTTP(S) server (NI)".blue
    puts "88. Back"
    puts "99. Exit Gladius"
    
    selection = gets.to_i
    case selection
    when 1 then ParseFile.new("Parse Files").menu
    when 2 then IPtables.new("KaliSupport", "List IPtables Rules").menu("list")
    when 3 then IPtables.new("KaliSupport", "Configure IPtables Rules").menu("config")
    when 4 then Atftpd.new("KaliSupport", "Setup a TFTP server").menu("config")
    when 5 then puts "Not implemented yet.".red
      menu
    when 6 then puts "Not implemented yet.".red
      menu 
    when 88 then Home.new.menu
    when 99 then GExeption.new.exit_gladius
    else puts "Invalid selection.".red
      menu
    end
  end
end


