#!/usr/bin/env ruby

# Author: p$3ud0R@nD0m

class Home
  def header_home
    puts "------------------------------"
    puts "Home                   v0.0.2"
    puts "------------------------------"
  end
    
  def menu
    header_home
    puts "Select a category:".light_yellow
    puts "1.  Gather information"
    puts "2.  Sniffing and Spoofing"
    puts "3.  Web attacks (NI)"
    puts "4.  Wireless attacks (NI)"
    puts "5.  Dictionary attacks"
    puts "6.  Config Kali services"
    puts "7.  Misc scripts"
    puts "99. Exit Gladius"
# ttd_1: refactor all menus
    sel = gets.to_i
    case sel
      when 1 then GatherInfo.new("Gather Information").menu
      when 2 then SniffSpoof.new("Sniffing and Spoofing").menu
      when 3 then puts "Not implemented yet.".red
        menu
      when 4 then puts "Not implemented yet.".red
        menu
      when 5 then Dictionary.new("Dictionary Attacks").menu
      when 6 then KaliServices.new("Configure Kali Services").menu
      when 7 then MiscScripts.new("Miscellaneous scripts").menu
      when 99 then GExeption.new.exit_gladius
      else 
        puts "Invalid selection.".red
        puts
        menu
    end
  end
end
