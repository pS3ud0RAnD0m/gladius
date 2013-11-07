# Author: p$3ud0R@nD0m

class ApacheUsers < Weapon
  def initialize(prev_menu, title)
    @prev_menu = prev_menu
    @title = title
    @path = "apache-users"
    @name = @path
    @apache_users_long = Path.get_path("apache_users_long")
    @stdn_hosts = []
  end

###############################################################################
# DRY methods
###############################################################################
  # Get target(s) and pass to relevant run method
  def menu(run_method)
    header
# ttd_1: get ports via x.x.x.x:80, then parse and pass to run methods
    instruct_input_targets("fqdn", "ip")
    while line = gets
      @stdn_hosts << line.chomp
    end
    if @stdn_hosts.count == 0
      puts "No hosts were input.".red
      menu(run_method)
    elsif @stdn_hosts.count == 1
      puts "Targeting " + @stdn_hosts[0] + " ..."
    else 
      hosts_count = @stdn_hosts.count
      puts "Targeting #{hosts_count} domains ..."
    end
    case run_method
      when "enum" then enum
    end
  rescue Interrupt
    GExeption.new.exit_weapon("Apache-users", @prev_menu)
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
  # Enum users
  def enum
    @out_file = get_out_file_txt(@name)
    out_file = @out_file
    @stdn_hosts.each do |host|
      `echo "------------------------------" >>#{out_file}`
      `echo "#{host}" >>#{out_file}`
      `echo "------------------------------" >>#{out_file}`
      cmd = @path + " -s 0 -e 403 -p 80 -t 8 -l " + @apache_users_long + " -h " + host + " |tee -a " + @out_file
      run(cmd)
    end
    clean_exit
  end
end
