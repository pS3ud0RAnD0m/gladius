# Author: p$3ud0R@nD0m

class CustomDictionary < Menu
  def menu
    header
    puts "Select a tactic:".light_yellow
    puts "Scrape a website:".yellow
    puts "1.  Output words (CeWL)"
    puts "2.  Output words and email addresses (CeWL)"
    puts "Mangle a list:".yellow
    puts "3.  Output basic (John)"
    puts "4.  Output l33t (John) (NI)".blue
    puts "5.  Output basic + l33t (John) (NI)".blue
    puts "Modify a list:".yellow
    puts "6.  Remove short and long words (Gladius) (NI)".blue
    puts "Other:".yellow
    puts "88. Back"
    puts "99. Exit Gladius"

    selection = gets.to_i
    case selection
    when 1 then Cewl.new("CustomDictionary", "CeWL - Scrape Words").menu("words")
    when 2 then Cewl.new("CustomDictionary", "CeWL - Scrape Words and Email Addresses").menu("emails")
    when 3 then John.new("CustomDictionary", "John - Basic Mangle").menu("basic")
    when 4 then puts "Not implemented yet.".red
      menu
    when 5 then puts "Not implemented yet.".red
      menu
    when 88 then puts "Not implemented yet.".red
      menu
    when 99 then GExeption.new.exit_gladius
    else puts "Invalid selection.".red
    menu
    end
  end
end

