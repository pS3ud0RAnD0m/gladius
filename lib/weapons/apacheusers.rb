# Author: p$3ud0R@nD0m

class ApacheUsers < Weapon
  def initialize(prev_menu, title)
    # Common
    @prev_menu = prev_menu
    @title = title
    # Weapon specific
    @name = "apache-users"
    @path = @name
    @port = ""
    @stdn_hosts = []
    # Weapon specific lists
    @apache_users_long = Path.get("apache_users_long")
  end

###############################################################################
# DRY methods
###############################################################################
  # Get target(s) and pass to relevant run method
  def menu(run_method)
    header
    instruct_input_targets("fqdn", "ip")
    while line = gets
      @stdn_hosts << line.chomp
    end
    if @stdn_hosts.count == 0
      no_input
      menu(run_method)
    end
    
# ttd_2: Mature this port request.
    puts "What port would you like to use? [443]".light_yellow
    @port = gets.chomp
    if @port.empty?
      @port = "443"
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
    @out_file = Path.get_out_file_txt(@name)
    out_file = @out_file
    @stdn_hosts.each do |host|
      `echo "------------------------------" >>#{out_file}`
      `echo "#{host}" >>#{out_file}`
      `echo "------------------------------" >>#{out_file}`
      cmd = @path + " -s 0 -e 403 -p " + @port + " -t 8 -l " + @apache_users_long + " -h " + host + " |tee -a " + @out_file
      run(cmd)
    end
    clean_exit
  end
end
