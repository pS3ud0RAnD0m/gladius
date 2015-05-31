# Author: p$3ud0R@nD0m

class Cewl < Weapon
  def initialize(prev_menu, title)
    # Common
    @name = self.class.to_s.downcase
    @path = @name
    @prev_menu = prev_menu
    @title = title
    # Weapon specific
    @site = ""
  end

###############################################################################
# User interaction methods
###############################################################################
  # Get target and pass to execute method
  def menu(run_method)
    header
    instruct_input_target("ip", "ipp", "fqdn", "fqdnp")
    @site = gets.chomp.downcase
    unless @site.empty?
      execute(run_method)
    else
      until !@site.empty? do
         no_input
         @site = gets.chomp.downcase
      end
    end
  rescue Interrupt
    GExeption.new.exit_weapon("Cewl", @prev_menu)
  end

  # Exit
  def clean_exit
    if File.exist?(@out_file)
      puts "Output can be found here:".yellow
      puts @out_file
    end
    exit_weapon
  end

###############################################################################
# Execution methods
###############################################################################
  # Execute method
  def execute(run_method)
    @out_file = Path.get_out_file(@name) + "_" + @site + ".txt"
    prependix = @path + " " + @site + " "
    appendix = " " + @out_file
      case run_method
      when "words" then cmd = prependix + "-m 8 -w" + appendix
      when "emails" then cmd = prependix + "-e -m 8 -w" + appendix
      end
    run(cmd)
    clean_exit
  end
end  
