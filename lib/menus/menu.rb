#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.0.1

class Menu
  attr_accessor :title
  def initialize
  end
  
  def splash
    puts
    puts "                                  /\\"
    puts "                                 /  \\"
    puts "                                 |  |"
    puts "                                 |  |"
    puts "                                 |  |"
    puts "                                 |  |"
    puts "                                 |  |"
    puts "    ________                  ___|  |"
    puts "   /  _____/ __  _____     __| _/|  |__ __   ________"
    puts "  /   \\  ___|  | \\__  \\   / __ | |  |  |  \\ /  _____/"
    puts "  \\    \\_\\  \\  |__/ __ \\_/ /_/ | |  |  |   /\\____  \\"
    puts "   \\______  /____/_____  /\\___ | |  |_____/________/"
    puts "          \\/           \\/     \\/ |__|"
    puts "                                [_  _]"
    puts "                                  ()"
    puts "    Viam inveniam aut faciam!     ()"
    puts "                                  ()"
    puts "                                 (  )    Find a way or make one!"
    puts "                                  \\/"
    puts
  end
  
  def header
    puts "------------------------------"
    puts @title
    puts "------------------------------"
  end
  
  def instruct_input1
    puts "Input target(s), one per line. When done, ensure the last line is blank and hit <CTRL> + <d>.".light_yellow
  end
  
  def example_input1
    puts "Example:".yellow
    puts "224.87.9.0/24".yellow
    puts
  end
  
  def example_input2
    puts "Examples:".yellow
    puts "10.14.0.36".yellow
    puts "192.168.15-250.0-255".yellow
    puts "10.87.9.0/24".yellow
    puts 
  end
  
  def example_input3
    puts "Examples:".yellow
    puts "225.14.0.36".yellow
    puts "224.87.9.0/24".yellow
    puts
  end
  
  def example_input4
    puts "Examples:".yellow
    puts "224.87.9.54".yellow
    puts
  end
  
  def example_input5
    puts "Examples:".yellow
    puts "www.victima.com".yellow
    puts "224.87.9.54".yellow
    puts
  end
end
