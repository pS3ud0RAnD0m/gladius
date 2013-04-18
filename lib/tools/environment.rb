#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.1

require_relative 'gptybasic'

class Environment
  def initialize
  end
  
  # Check requirements
  def requirements
    begin
      require 'colorize'
      Home.new("Home                   v0.0.1").menu
    rescue LoadError
      puts "Gladius requires the Ruby Gem 'Colorize'. May we install it for you? [Y/n]"
      a = gets.strip.downcase.chomp
      if a == "y" || a.empty?
        gem_install("colorize")
        puts
        Home.new("Home                   v0.0.1").menu
      elsif a == "n"
        begin
        puts "Exiting Gladius. Have a bloody day!"
        rescue Interrupt
        end
      else
        puts "Invalid selection."
        requirements
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
