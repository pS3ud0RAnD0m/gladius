# Author: p$3ud0R@nD0m

class Menu
  attr_accessor :title
  
  def initialize(title)
    @title = title
  end
  
  def header
    puts "----------------------------------------"
    puts @title
    puts "----------------------------------------"
  end
end
