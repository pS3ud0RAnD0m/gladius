#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

class Dictionary < Menu
  def menu
    header
    puts "Select a task:".light_yellow
    puts "1.  Create custom user/password lists (NI)"
    puts "2.  Online dictionary attacks"
    puts "3.  Offline dictionary attacks (NI)"
    puts "88. Back"
    puts "99. Exit Gladius"

    sel = gets.to_i
    puts
    if sel == 1
      puts "Not implemented yet.".red
      menu
    elsif sel == 2
      DictionaryOnline.new("Online Dictionary Attacks").menu
    elsif sel == 3
      puts "Not implemented yet.".red
      menu
    elsif sel == 88
      Home.new.menu
    elsif sel == 99
      begin
      puts "Exiting Gladius. Have a bloody day!".red
      rescue Interrupt
      end
    else
      puts "Invalid selection.".red
      menu
    end
  end
end

