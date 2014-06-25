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
    puts "4.  Output l33t (John)"
    puts "5.  Output basic + l33t (John)"
    puts "Modify a list:".yellow
    puts "6.  Remove short and long words (Gladius)"
    puts "Other:".yellow
    puts "88. Back"
    puts "99. Exit Gladius"

    selection = gets.to_i
    case selection
    when 1 then Cewl.new("CustomDictionary", "CeWL - Scrape Words").menu("words")
    when 2 then Cewl.new("CustomDictionary", "CeWL - Scrape Words and Email Addresses").menu("emails")
    when 3 then John.new("CustomDictionary", "John - Basic Mangle").menu("basic")
    when 4 then John.new("CustomDictionary", "John - L33t Mangle").menu("l33t")
    when 5 then John.new("CustomDictionary", "John - Basic + L33t Mangle").menu("basic_l33t")
    when 88 then Dictionary.new("Dictionary Attacks").menu
    when 99 then GExeption.new.exit_gladius
    else puts "Invalid selection.".red
    menu
    end
  end
end

