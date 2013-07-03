#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.2

require_relative '../helpers/colorize'
require_relative 'menu'
require_relative '../tools/snort'

class ConfigSnort < Menu
  def menu
    header
    puts "Select a task:".light_yellow
    puts "1.  Upgrade/Install Snort/Snorby and start (Gladius)"
    puts "2.  Modify Snort rules (Gladius) (NI)"
    puts "3.  Start Snort and Snorby (Gladius) (NI)"
    puts "88. Back"
    puts "99. Exit Gladius"

    sel = gets.to_i
    puts
    if sel == 1
      Snort.new("Upgrade/Install Snort/Snorby and Start").install
    elsif sel == 2
      puts "Not implemented yet.".red
      menu
    elsif sel == 3
      puts "Not implemented yet.".red
      menu
    elsif sel == 88
      BTServices.new("Configure Back Track Services").menu
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

