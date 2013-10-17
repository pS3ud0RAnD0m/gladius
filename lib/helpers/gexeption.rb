#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

class GExeption
  # Cleanly exit gladius
  def exit_gladius
    puts
    puts "Exiting Gladius. Have a bloody day!".red
    begin
      Kernel.exit
    rescue Exception => e
    puts
    end
  end
  
  # Cleanly exit a tool
  def exit_tool(tool, back)
    puts
    puts "Exiting #{tool}.".red
    puts
    case back
      when "DiscoverServices" then DiscoverServices.new("Discover Services").menu
      when "DictionaryOnline" then DictionaryOnline.new("Online Dictionary Attacks").menu
    end
  rescue Interrupt
    GExeption.new.exit_gladius
  end
end