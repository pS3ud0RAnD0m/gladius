#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require_relative 'gptybasic'

class Environment
  def initialize
  end
  
  # Check requirements
  def requirements
    begin
      require 'colorize'
      require_relative '../menus/home'
      Home.new("Home                   v0.0.2").menu
    rescue LoadError
      puts "Gladius requires the RubyGem 'Colorize'. Installing ..."
      gem_install("colorize")
      begin
        puts
        puts "Colorize has been installed, please restart Gladius."
      rescue Interrupt
      end
    end
  end
  
  # Get the Operating System
  def get_os
  end

  # Get the Ruby version
  def get_ruby
  end

  # Get the Gem version
  def get_gem
  end
  
  # Get the Gem version
  def get_gem_list
  end
  
  # Install a Gem
  def gem_install(gem_name)
    a = GptyBasic.new
    a.cmd = "gem install #{gem_name}"
    a.shell
  end
end
