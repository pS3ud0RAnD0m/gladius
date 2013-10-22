#!/usr/bin/env ruby

# Author: p$3ud0R@nD0m

require_relative 'menu'

class MiscScripts < Menu
  def menu
    header
    puts "Select a task:".light_yellow
    puts "1.  Parse files"
    puts "88. Back"
    puts "99. Exit Gladius"

    sel = gets.to_i
    puts
    case sel
      when 1 then Parse.new("Parse Files").menu
      when 88 then Home.new.menu
      when 99 then
        begin
          puts "Exiting Gladius. Have a bloody day!".red
          puts
        rescue Interrupt
        end
      else
        puts "Invalid selection.".red
        menu
    end
  end
end


