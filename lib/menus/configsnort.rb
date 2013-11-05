# Author: p$3ud0R@nD0m

require_relative 'menu'

class ConfigSnort < Menu
  def menu
    header
    puts "Select a task:".light_yellow
    puts "1.  Upgrade/Install Snort/Snorby and start (Gladius)"
    puts "2.  Modify Snort rules (Gladius) (NI)"
    puts "3.  Start Snort and Snorby (Gladius) (NI)"
    puts "88. Back"
    puts "99. Exit Gladius"
    selection = gets.to_i
    case selection
      when 1 then SnortService.new("Upgrade/Install Snort/Snorby and Start").install
      when 2 then puts "Not implemented yet.".red
      menu
      when 3 then puts "Not implemented yet.".red
      menu
      when 88 then KaliSupport.new("Configure Back Track Services").menu
      when 99 then GExeption.new.exit_gladius
      else puts "Invalid selection.".red
        menu
    end
  end
end
