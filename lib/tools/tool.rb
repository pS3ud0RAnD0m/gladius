#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.0.1

class Tool
  attr_accessor :title
  
  def header
    puts "----------"
    puts @title
    puts "----------"
  end
  
  #def input_val
  #  if @@hosts.count == 0
  #    puts "No hosts were input.".red
  #    puts
  #    menu
  #  end
  #end
end
