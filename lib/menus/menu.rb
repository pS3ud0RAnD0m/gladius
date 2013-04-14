#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.0.1

class Menu
  attr_accessor :title
  
  def initialize(title)
    @title = title
  end
  
  def header
    puts "------------------------------"
    puts @title
    puts "------------------------------"
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
end
