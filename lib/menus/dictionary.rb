# Author: p$3ud0R@nD0m

class Dictionary < Menu
  def menu
    header
    puts "Select a tactic:".light_yellow
    puts "1.  Create custom dictionaries"
    puts "2.  Online dictionary attacks"
    puts "3.  Offline dictionary attacks (NI)".blue
    puts "88. Back"
    puts "99. Exit Gladius"
    
    selection = gets.to_i
    case selection
    when 1 then CustomDictionary.new("Create Custom Dictionaries").menu
    when 2 then DictionaryOnline.new("Online Dictionary Attacks").menu
    when 3 then puts "Not implemented yet.".red
      menu
    when 88 then Home.new.menu
    when 99 then GExeption.new.exit_gladius
    else puts "Invalid selection.".red
      menu
    end
  end
end
