# Author: p$3ud0R@nD0m

class Enum4linux < Weapon
  def initialize(prev_menu, title)
    # Common
    @name = self.class.to_s.downcase
    @path = @name
    @prev_menu = prev_menu
    @title = title
    # Weapon specific
    @stdn_hosts = []
  end

###############################################################################
# User interaction methods
###############################################################################
  # Get target(s) and pass to execute method
  def menu(run_method)
    header
    instruct_input_targets("ip")
    while line = gets
      @stdn_hosts << line.chomp
    end
    if @stdn_hosts.count == 0
      puts "No hosts were input.".red
      menu(run_method)
    elsif @stdn_hosts.count == 1
      puts "Targeting " + @stdn_hosts[0] + " ..."
      execute(run_method)
    else 
      hosts_count = @stdn_hosts.count
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
    @stdn_hosts.each do |host|
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
