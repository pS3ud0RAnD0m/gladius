# Author: p$3ud0R@nD0m

class DNSrecon < Weapon
  def initialize(prev_menu, title)
    @prev_menu = prev_menu
    @title = title
    @path = "dnsrecon"
    @name = @path
    @stdn_hosts = []
  end

###############################################################################
# DRY methods
###############################################################################
  # Get target(s) and pass to relevant run method
  def menu(run_method)
    header
    case run_method
      when "transfer" then instruct_input_targets("fqdn")
      when "standard" then instruct_input_targets("fqdn")
      when "google" then instruct_input_targets("cidr")
      when "reverse" then instruct_input_targets("iprl", "cidr")
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
      when "transfer" then transfer
      when "standard" then standard
      when "google" then google
      when "reverse" then reverse
    end
  rescue Interrupt
    GExeption.new.exit_weapon("DNSRecon", @prev_menu)
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
  # Attempt a zone transfer:
  def transfer
    @out_file = get_out_file_txt(@name)
    out_file = @out_file
    @stdn_hosts.each do |host|
      `echo "------------------------------" >>#{out_file}`
      `echo "#{host}" >>#{out_file}`
      `echo "------------------------------" >>#{out_file}`
      cmd = @path + " --threads 2 -t axfr -d " + host + " |tee -a " + @out_file
      run(cmd)
    end
    clean_exit
  end
  
  # Attempt a zone transfer, then enum standard records:
  def standard
    @out_file = get_out_file_txt(@name)
    out_file = @out_file
    @stdn_hosts.each do |host|
      `echo "------------------------------" >>#{out_file}`
      `echo "#{host}" >>#{out_file}`
      `echo "------------------------------" >>#{out_file}`
      cmd = @path + " --threads 2 -a -d " + host + " |tee -a " + @out_file
      run(cmd)
    end
    clean_exit
  end

  # Perform Google search for sub-domains and @stdn_hosts:
  def google
    @out_file = get_out_file_txt(@name)
    out_file = @out_file
    @stdn_hosts.each do |host|
      `echo "------------------------------" >>#{out_file}`
      `echo "#{host}" >>#{out_file}`
      `echo "------------------------------" >>#{out_file}`
      cmd = @path + " --threads 2 -t goo -d " + host + " |tee -a " + @out_file
      run(cmd)
    end
    clean_exit
  end
  
  # Reverse lookups for given block
  def reverse
    @out_file = get_out_file_txt(@name)
    out_file = @out_file
    @stdn_hosts.each do |host|
      `echo "------------------------------" >>#{out_file}`
      `echo "#{host}" >>#{out_file}`
      `echo "------------------------------" >>#{out_file}`
      cmd = @path + " --threads 2 -t rvl -r " + host + " |tee -a " + @out_file
      run(cmd)
    end
    clean_exit
  end
end  
