#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

class Session
  def create
    Splash.new.display
    Home.new.menu
  end
end
