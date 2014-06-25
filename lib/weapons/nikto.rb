#!/usr/bin/env ruby

# Author: p$3ud0R@nD0m

class Nikto < Weapon
  def initialize(prev_menu, title)
    # Common
    @name = self.class.to_s.downcase
    @path = @name
    @prev_menu = prev_menu
    @stdn_hosts = Path.get("share_stdn_hosts")
    @title = title
  end

###############################################################################
# DRY methods
###############################################################################
  # Get target(s) and pass to relevant scan method
  def menu(run_method)
    header
    puts "Will your targets be using SSL? [Y/n]".light_yellow
    ssl = gets.chomp.downcase
    case ssl
      when "n" then run_method = "common"
      else run_method = "common_ssl"
    end
    puts
    instruct_input_targets("fqdn", "ip", "fqdnp", "ipp", "url")
    a = File.open(@stdn_hosts, "w")
    while line = gets
      a << line
    end
    a.close
    hosts = @stdn_hosts
    line_count = `wc -l #{hosts}`.to_i
    if line_count == 0
      no_input
      menu(run_method)
    else
      case run_method
        # Pass discovery scans
        when "common" then common
        when "common_ssl" then common_ssl
      end
    end
  rescue Interrupt
    GExeption.new.exit_weapon("Nikto", @prev_menu)
  end

  # Exit
  def clean_exit
    if File.exist?(@out_file)
      puts "Raw output can be found here:".yellow
      puts @out_file
    end
    exit_weapon
  end

###############################################################################
# Run methods
###############################################################################
  # Discover common vulns without SSL
  def common
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -C all -h " + @stdn_hosts + " |tee " + @out_file
    run(cmd)
    clean_exit
  end

  # Discover common vulns over SSL
  def common_ssl
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " -ssl -C all -h " + @stdn_hosts + " |tee " + @out_file
    run(cmd)
    clean_exit
  end
end
