#!/usr/bin/env ruby

# Author: p$3ud0R@nD0m

class SSLScan < Weapon
  def initialize(prev_menu, title)
    @prev_menu = prev_menu
    @title = title
    @path = "sslscan"
    @name = @path
    @hosts_file = Path.hosts_file
  end

###############################################################################
# DRY methods
###############################################################################
  # Get target(s) and pass to relevant scan method
  def menu(scan_type)
    header
    instruct_input_targets("fqdn", "fqdnp", "ip", "ipp")
    a = File.open(@hosts_file, "w")
    while line = gets
      a << line
    end
    a.close
    hosts = @hosts_file
    line_count = `wc -l #{hosts}`.to_i
    if line_count == 0
      puts "No hosts were input.".red
      menu
    else
      case scan_type
        # Pass discovery scans
        when "common" then common
      end
    end
  rescue Interrupt
    GExeption.new.exit_weapon("SSLScan", @prev_menu)
  end
    
  # Cleanly exit
  def clean_exit
    puts
    if File.exist?(@out_file)
      out_file = @out_file
# ttd_3: let's just show weak protocols/ciphers here
      parsed = `egrep "Testing|Accepted" #{out_file}`
      puts "The following protocols/ciphers were accepted:".light_yellow
      puts parsed
      puts
      puts "Raw output can be found here:".yellow
      puts @out_file
    end
    exit_weapon
  end
  
###############################################################################
# Run methods
###############################################################################
  # Discover supported SSL/TLS certs
  def common
    @out_file = get_out_file_txt(@name)
    cmd = @path + " --no-failed --targets=" + @hosts_file + " |tee " + @out_file
    run(cmd)
    clean_exit
  end
end
