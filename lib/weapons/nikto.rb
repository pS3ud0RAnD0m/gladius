#!/usr/bin/env ruby

# Author: p$3ud0R@nD0m

class Nikto < Weapon
  def initialize(prev_menu, title)
    @prev_menu = prev_menu
    @title = title
    @path = "nikto"
    @name = @path
    @stdn_hosts = Path.get_path("stdn_hosts")
  end

###############################################################################
# DRY methods
###############################################################################
  # Get target(s) and pass to relevant scan method
  def menu(scan_type)
    header
    puts "Will your targets be using SSL? [Y/n]".light_yellow
    ssl = gets.chomp.downcase
    case ssl
      when "n" then scan_type = "common"
      else scan_type = "common_ssl"
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
      puts "No hosts were input.".red
      menu
    else
      case scan_type
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
    @out_file = get_out_file_txt(@name)
    cmd = @path + " -C all -h " + @stdn_hosts + " -output " + @out_file
    run(cmd)
    clean_exit
  end

  # Discover common vulns over SSL
  def common_ssl
    @out_file = get_out_file_txt(@name)
    cmd = @path + " -ssl -C all -h " + @stdn_hosts + " -output " + @out_file
    run(cmd)
    clean_exit
  end
end
