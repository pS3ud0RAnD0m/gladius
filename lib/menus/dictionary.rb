# Author: p$3ud0R@nD0m

class Dictionary < Menu
  def menu
    header
    puts "Select a task:".light_yellow
    puts "1.  Create custom user/password lists (NI)"
    puts "2.  Online dictionary attacks"
    puts "3.  Offline dictionary attacks (NI)"
    puts "88. Back"
    puts "99. Exit Gladius"
    selection = gets.to_i
    case selection
      when 1 then puts "Not implemented yet.".red
        menu
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
