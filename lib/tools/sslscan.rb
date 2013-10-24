#!/usr/bin/env ruby

# Author: p$3ud0R@nD0m

class SSLScan < Tool
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
    GExeption.new.exit_tool("SSLScan", @prev_menu)
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
    puts
    case @prev_menu
      when "HTTP" then HTTP.new("Gather Information - HTTP(S)").menu
    end
  rescue Interrupt
    GExeption.new.exit_gladius
  end
  
###############################################################################
# Discovery methods
###############################################################################
  # Discover supported SSL/TLS certs
  def common
    @out_file = get_out_file_txt(@name)
    cmd = @path + " --no-failed --targets=" + @hosts_file + " |tee " + @out_file
    run(cmd)
    clean_exit
  end
end
