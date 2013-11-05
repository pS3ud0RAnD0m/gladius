# Author: p$3ud0R@nD0m

class SysInfo
  def initialize
  end

###############################################################################
# Get methods
###############################################################################
# ttd_4: Rubify get methods these.
  # Get the Operating System
  def get_os
  end

  # Get the system's currrent DNS server(s)
  def get_dns_server
    # Get dns server
    dns_server = `nslookup server |grep Server |awk '{print $2}'`.chomp
    puts dns_server
  end

  # Get the system's currrent ip address(es)
  def get_ip
    ip = `ifconfig |grep Bcast |awk '{print $2}' |awk -F ":" '{print $2}'`.chomp
    puts ip
  end

  # Get the system's currrent domain
  def get_domain
    domain = `cat /etc/resolv.conf |grep domain |awk '{print $2}'`.chomp
    puts domain
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

###############################################################################
# Check methods
###############################################################################
  # Check requirements
  def check_requirements
    begin
      #require 'colorize'
      require_relative '../menus/home'
      Home.new.menu
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

###############################################################################
# Install methods
###############################################################################
  # Install a Gem
  def gem_install(gem_name)
    a = Gpty.new
    a.cmd = "gem install #{gem_name}"
    a.shell_basic
  end
end
