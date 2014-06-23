# Author: p$3ud0R@nD0m

class CustomDictionary < Menu
  def menu
    header
    puts "Select a task:".light_yellow
    puts "1.  Scrape words from a website (CeWL)"
    puts "2.  Scrape words and email addresses from a website (CeWL)"
    puts "88. Back"
    puts "99. Exit Gladius"

    selection = gets.to_i
    puts
    case selection
    when 1 then Cewl.new("CustomDictionary", "CeWL - Scrape Words").menu("words")
    when 2 then Cewl.new("CustomDictionary", "CeWL - Scrape Words and Email Addresses").menu("emails")
    when 88 then Dictionary.new("Dictionary Attacks").menu
    when 99 then GExeption.new.exit_gladius
    else puts "Invalid selection.".red
    menu
    end
  end
end

