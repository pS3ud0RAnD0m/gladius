#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.1

require_relative 'gptybasic'
#require_relative '../menus/home'

class Environment
  def initialize
  end
  
  # Check requirements
  def requirements
    begin
      require 'colorize'
#      Home.new("Home                   v0.0.1").menu
      puts "mark 1"
      env_test
    rescue LoadError
      gem_install("colorize")
      puts "mark 2"
      gem 'colorize'
      require_relative '../menus/home'
      Home.new("").test
#      require_relative '../menus/home'
#      Home.new("Home                   v0.0.1").menu
#      puts "mark 3"
    end
  end
  
  def env_test
    puts "This is env_test..."
    require_relative '../menus/home'
    Home.new("").test
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
