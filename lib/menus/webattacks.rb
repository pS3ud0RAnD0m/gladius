# Author: p$3ud0R@nD0m

class WebAttacks < Menu
  
  def menu
    header
    puts "Select a task:".light_yellow
    puts "1.  ..."
    puts "2.  ..."
    puts "3.  ..."
    puts "88. Back"
    puts "99. Exit Gladius"
    
    selection = gets.to_i
    case selection
    when 1 then puts "Not implemented yet.".red
      menu
    when 2 then puts "Not implemented yet.".red
      menu
    when 3 then puts "Not implemented yet.".red
      menu
    when 88 then Home.new.menu
    when 99 then GExeption.new.exit_gladius
    else puts "Invalid selection.".red
      menu
    end
  end
end
