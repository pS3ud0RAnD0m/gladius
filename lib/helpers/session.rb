# Author: p$3ud0R@nD0m

require_relative '../menus/splash'

class Session
  def create
    Splash.new.iterate
    Home.new.menu
  end
end
