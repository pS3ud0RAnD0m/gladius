# Author: p$3ud0R@nD0m

class CustomDictionary < Menu
  def menu
    header
    puts "Select a tactic:".light_yellow
    puts "Scrape a website:".yellow
    puts "1.  Output words (CeWL)"
    puts "2.  Output words and email addresses (CeWL)"
    puts "Mangle a list:".yellow
    puts "3.  Basic (John)"
    puts "4.  L33t (John)"
    puts "5.  Basic & l33t (John) (NI)".blue
    puts "6.  Basic & basic > l33t (John) (NI)".blue
    puts "Modify a list:".yellow
    puts "7.  Remove short and long words (Gladius) (NI)".blue
    puts "Other:".yellow
    puts "88. Back"
    puts "99. Exit Gladius"

    selection = gets.to_i
    case selection
    when 1 then Cewl.new("CustomDictionary", "CeWL - Scrape Words").menu("words")
    when 2 then Cewl.new("CustomDictionary", "CeWL - Scrape Words and Email Addresses").menu("emails")
    when 3 then John.new("CustomDictionary", "John - Basic Mangle").menu("basic")
    when 4 then John.new("CustomDictionary", "John - L33t Mangle").menu("l33t")
    #when 5 then John.new("CustomDictionary", "John - Basic plus L33t Mangle").menu("basic_and_l33t")
    #when 6 then John.new("CustomDictionary", "John - Basic then L33t Mangle").menu("basic_thru_l33t")
    when 5 then puts "Not implemented yet.".red
      menu
    when 6 then puts "Not implemented yet.".red
      menu
    when 7 then puts "Not implemented yet.".red
      menu
    when 88 then Dictionary.new("Dictionary Attacks").menu
    when 99 then GExeption.new.exit_gladius
    else puts "Invalid selection.".red
    menu
    end
  end
end

