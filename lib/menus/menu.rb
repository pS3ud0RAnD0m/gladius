#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.1

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
end
