#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.0.1

require 'colorize'
require_relative 'menu'
require_relative 'gatherinfo'
require_relative 'mangexploits'
require_relative 'web'
require_relative 'wireless'
require_relative 'btservices'

class Home < Menu
  def menu
    puts "Select a category:".light_yellow
    puts "1. Gather information"
    puts "2. Manage exploits"
    puts "3. Web attacks"
    puts "4. Wireless attacks"
    puts "5. Configure Back Track services"
    puts "6. Exit Gladius"

    sel = gets.to_i
    puts
    if sel == 1
      @title = "Gather Information"
      header
      GatherInfo.new.menu
    elsif sel == 2
      @title = "Manage Exploits"
      header
      MangExploits.new.menu
    elsif sel == 3
      @title = "Web Attacks"
      header
      Web.new.menu
    elsif sel == 4
      @title = "Wireless Attacks"
      header
      Wireless.new.menu
    elsif sel == 5
      @title = "Configure Back Track Services"
      header
      BTServices.new.menu
    elsif sel == 6
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

