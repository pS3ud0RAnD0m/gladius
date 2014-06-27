# Author: p$3ud0R@nD0m

class John < Weapon
  def initialize(prev_menu, title)
    # Common
    @name = self.class.to_s.downcase
    @path = @name
    @prev_menu = prev_menu
    @title = title
    # Weapon specific
    @korelogic_rules = Path.get("korelogic_rules")
    @share_seed = Path.get("share_seed")
    @share_sprout = Path.get("share_sprout")
    @tmp_file = get_tmp_file
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
      # cp to share_seed
      
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
      puts "#{count_lines_file(@out_file)} words in the new list.".light_yellow
      puts "Your list is here:".yellow
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
    prependix = "#{@path} -w=#{@share_seed} -rules"
    appendix = " -stdout >#{@out_file}"
      case run_method
      when "basic" then
        cmd = prependix + appendix
        run(cmd)
        clean_exit
      when "l33t" then
        cmd = "#{prependix}=KoreLogicRulesL33t -config=#{@korelogic_rules} #{appendix}"
        run(cmd)
        clean_exit
      when "basic_plus_l33t" then
        cmd = "#{prependix}=KoreLogicRulesL33t -config=#{@korelogic_rules} -stdout >#{@share_sprout}"
        run(cmd)
        cmd = prependix + appendix
        run(cmd)
        `cat #{@share_sprout} >>#{@out_file}`
        clean_exit
      when "basic_thru_l33t" then
        cmd = "#{prependix} -stdout >#{@share_sprout}"
        run(cmd)
        cmd = "#{@path} -w=#{@share_sprout} -rules=KoreLogicRulesL33t -config=#{@korelogic_rules} -stdout >>#{@out_file}"
        run(cmd)
# ttd_3: rubify these bash commands.
        `cat #{@out_file} >#{@tmp_file}`
        `cat #{@share_sprout} >#{@out_file}`
        `cat #{@tmp_file} >>#{@out_file}`
        `rm #{@tmp_file}`
        clean_exit
      end
  end
end  
