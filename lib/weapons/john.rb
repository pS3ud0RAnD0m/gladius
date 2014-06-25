# Author: p$3ud0R@nD0m

class John < Weapon
  def initialize(prev_menu, title)
    # Common
    @name = self.class.to_s.downcase
    @path = @name
    @prev_menu = prev_menu
    @title = title
    # Weapon specific
    @share_seed = Path.get("share_seed")
  end

###############################################################################
# User interaction methods
###############################################################################
  # Get list and pass to execute method
  def menu(run_method)
    header
    puts "Select your input method:".light_yellow
    puts "1. STDIN"
    puts "2. File path"
    selection = gets.to_i
    case selection
    when 1 then
      get_input("stdin_to_file", "words", @share_seed)
      execute(run_method)
    when 2 then
      get_input("gets_to_var", "words_list", @share_seed)
      execute(run_method)
    else puts "Invalid selection.".red
    menu(run_method)
    end
  rescue Interrupt
    GExeption.new.exit_weapon("John", @prev_menu)
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
    @out_file = Path.get_out_file(@name) + "_#{run_method}.txt"
    prependix = @path + " -w=" + @share_seed + " -rules -stdout >"
    appendix = @out_file
      case run_method
      when "basic" then cmd = prependix + appendix
      when "l33t" then cmd = prependix + "-e -m 8 -w" + appendix
      when "basic_l33t" then cmd = prependix + "-e -m 8 -w" + appendix
      end
    run(cmd)
    clean_exit
  end
end  
