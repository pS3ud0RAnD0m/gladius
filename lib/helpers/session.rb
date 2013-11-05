# Author: p$3ud0R@nD0m

class Session
  def create
    Splash.new.iterate
    Home.new.menu
  end
end
