# Author: p$3ud0R@nD0m

class ParseFile < Menu
  
  def menu
    header
    puts "Select a tactic:".light_yellow
    puts "1.  Nmap XML > CSV spreadsheet (Gladius)"
    #puts "2.  Nmap XML > open ports text file (Gladius)"
    puts "88. Back"
    puts "99. Exit Gladius"
    
    selection = gets.to_i
    case selection
    when 1 then Parse.new("ParseFile", "Parse Nmap XML File").menu("nmap_xml_to_csv")
    when 88 then KaliSupport.new("Kali Support").menu
    when 99 then GExeption.new.exit_gladius
    else puts "Invalid selection.".red
      menu
    end
  end
end
