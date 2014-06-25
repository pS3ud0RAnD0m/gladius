# Author: p$3ud0R@nD0m

class SSLScan < Weapon
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
  def menu(scan_type)
    puts "Note: SSLScan uses OpenSSL. OpenSSL recently disabled SSLv2, by default.".light_yellow
    header
    instruct_input_targets("fqdn", "fqdnp", "ip", "ipp")
    a = File.open(@stdn_hosts, "w")
    while line = gets
      a << line
    end
    a.close
    hosts = @stdn_hosts
    line_count = `wc -l #{hosts}`.to_i
    if line_count == 0
      no_input
      menu(scan_type)
    else
      case scan_type
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
    @out_file = Path.get_out_file_txt(@name)
    cmd = @path + " --no-failed --targets=" + @stdn_hosts + " |tee " + @out_file
    run(cmd)
    clean_exit
  end
end
