# Author:  p$3ud0R@nD0m

class Fierce < Weapon
  def initialize(prev_menu, title)
    @prev_menu = prev_menu
    @title = title
    @path = "fierce"
    @name = @path
    @stdn_hosts = []
    @dns_hosts_long = Path.get_path("dns_hosts_long")
  end

###############################################################################
# DRY methods
###############################################################################
  # Get target(s) and pass to relevant run method
  def menu(run_method)
    header
    case run_method
    when "dictionary" then instruct_input_targets("domain")
    end
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
    when "dictionary" then dictionary
    end
  rescue Interrupt
    GExeption.new.exit_weapon("Fierce", @prev_menu)
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
  # Attempt a zone transfer and dictionary attack records
  def dictionary
    @out_file = get_out_file_txt(@name)
    out_file = @out_file
    @stdn_hosts.each do |host|
      `echo "------------------------------" >>#{out_file}`
      `echo "#{host}" >>#{out_file}`
      `echo "------------------------------" >>#{out_file}`
      cmd = @path + " --threads 2 -wordlist " + @dns_hosts_long + " -dns " + host + " |tee -a " + @out_file
      run(cmd)
    end
    clean_exit
  end
end
