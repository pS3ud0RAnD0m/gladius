# Author: p$3ud0R@nD0m

class Enum4linux < Weapon
  def initialize(prev_menu, title)
    # Common
    @name = self.class.to_s.downcase
    @path = @name
    @prev_menu = prev_menu
    @title = title
    # Weapon specific
    @stdin_hosts = []
  end

###############################################################################
# User interaction methods
###############################################################################
  # Get target(s) and pass to execute method
  def menu(run_method)
    header
    instruct_input_targets("ip")
    while line = gets
      @stdin_hosts << line.chomp
    end
    if @stdin_hosts.count == 0
      no_input
      menu(run_method)
    elsif @stdin_hosts.count == 1
      puts "Targeting " + @stdin_hosts[0] + " ..."
      execute(run_method)
    else 
      hosts_count = @stdin_hosts.count
      puts "Targeting #{hosts_count} hosts ..."
      execute(run_method)
    end
  rescue Interrupt
    GExeption.new.exit_weapon("Enum4linux", @prev_menu)
  end

  # Clean exit
  def clean_exit
    puts
    puts "prev_menu is: " + @prev_menu
    if File.exist?(@out_file)
      puts "Raw output can be found here:".yellow
      puts @out_file
    end
    exit_weapon
  end

###############################################################################
# Execution methods
###############################################################################
  # Execute run method
  def execute(run_method)
    @out_file = Path.get_out_file_txt(@name)
    out_file = @out_file
    @stdin_hosts.each do |host|
      `echo "------------------------------" >>#{out_file}`
      `echo "#{host}" >>#{out_file}`
      `echo "------------------------------" >>#{out_file}`
      case run_method
      when "all" then cmd = @path + " -a #{host} |tee -a #{out_file}"
      end
      run(cmd)
    end
    clean_exit
  end
end  
