#!/usr/bin/env ruby

# Author: P$3ud0R@nD0m
# Version: 0.0.1

require 'colorize'
require_relative 'tool'
require_relative 'gpty'

class Snort < Tool
  def initialize(title)
    @title = title
  end
  
  # Install and configure Snort w/Snorby
  def install
    header
    puts
    puts "Downloading and installing Snorby".light_yellow
    puts "----------------------------------".light_yellow
    puts "Running: cd /var/www".light_yellow
    Dir.chdir("/var/www") do
      a = Gpty.new
      a.cmd = "git clone git://github.com/Snorby/snorby.git"
      a.shell
    end
    puts "Running: cd /var/www/snorby".light_yellow
    Dir.chdir("/var/www/snorby") do
      a = Gpty.new
      a.cmd = "gem install rake -v 0.9.2"
      a.shell
      a.cmd = "bundle install"
      a.shell
      puts
    end
    
    puts "Editing Snorby's database files".light_yellow
    puts "--------------------------------".light_yellow
    a = Gpty.new
    a.cmd = "cp /var/www/snorby/config/database.yml.example /var/www/snorby/config/database.yml"
    a.shell
    a.cmd = "cp /var/www/snorby/config/snorby_config.yml.example /var/www/snorby/config/snorby_config.yml"
    a.shell
    puts "Editing: /var/www/snorby/config/database.yml".light_yellow
    a = File.read("/var/www/snorby/config/database.yml")
    replace = a.gsub(/"Enter Password Here"/, "toor")
    File.open("/var/www/snorby/config/database.yml", "w") {|file| file.puts replace}
    puts
    
    puts "Configuring MySQL".light_yellow
    puts "------------------".light_yellow
    a = Gpty.new
    a.cmd = "service mysql start"
    a.shell
    a.cmd = "/root/Desktop/dev/scripts/rb/gladius/lib/shells/mysql.sh snorby snorby snorby"
    a.shell
    a.cmd = "/root/Desktop/dev/scripts/rb/gladius/lib/shells/mysql.sh snorby snort snort"
    a.shell
    puts
    
    puts "Removing old Snort install".light_yellow
    puts "---------------------------".light_yellow
    a.cmd = "apt-get -y remove snort"
    a.shell
    puts
    
    puts "Instructions for installing Snort-MySQL".light_yellow
    puts "----------------------------------------".light_yellow
    puts "During the install, you'll need to answer a few GLI (ncurses) questions.".light_yellow
    puts "No worries. Need be, the settings can easily be changed later.".light_yellow
    puts "Open another shell and run the following command:".light_yellow
    puts "apt-get -y install snort-mysql".yellow
    puts
    
    puts "Answer the questions as follows:".light_yellow
    puts "Address range for the local network: => <ip_address/32>".yellow
    puts "Set up a database for snort-mysql to log to? => Yes".yellow
    puts
    puts "Once you've completed the instructions directly above, hit Enter.".light_yellow
    a = gets.chomp
    
    puts "Configuring Snort".light_yellow
    puts "------------------".light_yellow
    a = Gpty.new
    puts "Editing: /etc/snort/snort.conf".light_yellow
    a = File.read("/etc/snort/snort.conf")
    replace = a.gsub(/# output database: log, mysql, user=root password=test dbname=db/, "output database: log, mysql, user=snort password=snort dbname=snorby")
    File.open("/etc/snort/snort.conf", "w") {|file| file.puts replace}
    if File.exist?("/etc/snort/db-pending-config")
      a = Gpty.new
      a.cmd = "mv /etc/snort/db-pending-config /etc/snort/db-pending-config.orig"
      a.shell
    end
    puts
    
    puts "Starting Services".light_yellow
    puts "------------------".light_yellow
    puts "Running: cd /var/www/snorby".light_yellow
    Dir.chdir("/var/www/snorby") do
      a = Gpty.new
      a.cmd = "bundle exec rake snorby:setup RAILS_ENV=production"
      a.shell
      a.cmd = "bundle exec rails server -e production --binding=127.0.0.1 -d"
      a.shell
      a.cmd = "service snort start"
      a.shell
      a.cmd = "ps -ef |grep -v grep |grep \"snort\\|rails\""
      a.shell
    end
    puts
    
    puts "Snorby is ready!".light_yellow
    puts "-----------------".light_yellow
    puts "Navigate to http://localhost:3000".light_yellow
    puts "u = snorby@snorby.org".yellow
    puts "p = snorby".yellow
  end
end
