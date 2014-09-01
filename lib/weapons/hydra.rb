# Author: p$3ud0R@nD0m

class Hydra < Weapon
  def initialize(prev_menu, title)
    # Common
    @name = self.class.to_s.downcase
    @path = @name
    @prev_menu = prev_menu
    @title = title
    # Weapon specific
    @init_dir = Dir.pwd
    @input_type = ""
    @port = ""
    @run_type = ""
    @share_output = Path.get("share_output")
    # Weapon specific lists

    @stdin_pwds = Path.get("share_stdin_pwds")
    @stdin_usrs = Path.get("share_stdin_usrs")
    
    @usrs_file = ""
    @pwds_file = ""
    @hosts_file = Path.get("share_stdin_hosts")
    @gladius_usrs_file_long = ""
    @gladius_pwds_file_long = ""
  end

###############################################################################
# Menu methods
###############################################################################
  # Get target(s)
  def get_targets(run_type)
    @run_type = run_type
    header
# ttd_1: ask for port
    # Get port
    #case @run_type
    #when "ftp" then get_port(21)
    #when "http" then get_port(80)
    #when "mysql" then get_port(3306)
    #when "rexec" then get_port(512)
    #when "rlogin" then get_port(513)
    #when "rsh" then get_port(514)
    #when "smtp" then get_port(25)
    #when "ssh" then get_port(22)
    #when "telnet" then get_port(23)
    #when "vmauthd" then get_port(1)
    #when "vnc" then get_port(5900)
    #end
    Dir.chdir(@share_output)
    instruct_input_targets("fqdn", "ip")
    a = File.open(@hosts_file, "w")
    while line = gets
      a << line
    end
    a.close
    hosts_file = @hosts_file
    line_count = count_lines_file(hosts_file)
    if line_count == 0
      get_targets(@run_type)
    else
      puts "Select your tactic:".light_yellow
    end
    
    # Pass proper dictionary to get_input_type
    case @run_type
    when "rexec" then get_input_type("ssh")
    when "rlogin" then get_input_type("ssh")
    when "rsh" then get_input_type("ssh")
    when "vmauthd" then get_input_type("ssh")
    else
      get_input_type(@run_type)
    end
  rescue Interrupt
    GExeption.new.exit_weapon("Hydra", @prev_menu)
  end

  # Get input type
  def get_input_type(dictionary)
    case dictionary
    when "vnc" then
      @gladius_pwds_file_long = Path.get("#{dictionary}_pwds_long")
      pwds_count = count_lines_file(@gladius_pwds_file_long)
      puts "1. #{pwds_count} attempts/host = #{pwds_count} passwords"
    else
      @gladius_pwds_file_long = Path.get("#{dictionary}_pwds_long")
      @gladius_usrs_file_long = Path.get("#{dictionary}_usrs_long")
      pwds_count = count_lines_file(@gladius_pwds_file_long) + 2
      usrs_count = count_lines_file(@gladius_usrs_file_long)
      mult_count = usrs_count * pwds_count
      puts "1. #{mult_count} attempts/host = #{usrs_count} users * #{pwds_count} passwords"
    end
    puts "2. Input your own users and passwords"
    puts "3. Input your own user and password files"
    selection = gets.to_i

    case selection
    when 1 then
      @usrs_file = @gladius_usrs_file_long
      @pwds_file = @gladius_pwds_file_long
      execute
    when 2 then
      instruct_input_usrs(dictionary)
      @usrs_file = Path.get("share_stdin_usrs")
      get_input("stdin_to_file", @usrs_file)
      instruct_input_pwds(dictionary)
      @pwds_file = Path.get("share_stdin_pwds")
      get_input("stdin_to_file", @pwds_file)
      execute
    when 3 then
# ttd_1: vnc does not have a user
      instruct_input_usrs_list
      @usrs_file = gets.chomp
      instruct_input_pwds_list
# ttd_3: Does not check for empty input.
      @pwds_file = gets.chomp
      execute
    end
  rescue Interrupt
    GExeption.new.exit_weapon("Hydra", @prev_menu)
  end

###############################################################################
# Execution method
###############################################################################
# Execute method
  def execute
    @out_file = Path.get_out_file_txt(@name)
    cmd_prefix = "#{@path} -V -w 64 -e ns -t"
    cmd_suffix = "|tee #{@out_file}"
    case @run_type
    when "ftp"      then cmd_infix = "8 -L #{@usrs_file} -P #{@pwds_file} -M #{@hosts_file} ftp"
    when "mssql"    then cmd_infix = "4 -L #{@usrs_file} -P #{@pwds_file} -M #{@hosts_file} mssql"
    when "mysql"    then cmd_infix = "4 -L #{@usrs_file} -P #{@pwds_file} -M #{@hosts_file} mysql"
    when "postgres" then cmd_infix = "8 -L #{@usrs_file} -P #{@pwds_file} -M #{@hosts_file} postgres"
    when "rexec"    then cmd_infix = "8 -L #{@usrs_file} -P #{@pwds_file} -M #{@hosts_file} rexec -s 512"
    when "rlogin"   then cmd_infix = "8 -L #{@usrs_file} -P #{@pwds_file} -M #{@hosts_file} rlogin -s 513"
    when "rsh"      then cmd_infix = "8 -L #{@usrs_file} -P #{@pwds_file} -M #{@hosts_file} rsh -s 514"
    when "ssh"      then cmd_infix = "8 -L #{@usrs_file} -P #{@pwds_file} -M #{@hosts_file} ssh -s 22"
    when "telnet"   then cmd_infix = "8 -L #{@usrs_file} -P #{@pwds_file} -M #{@hosts_file} telnet -s 23"
    when "vmauthd"  then cmd_infix = "8 -L #{@usrs_file} -P #{@pwds_file} -M #{@hosts_file} vmauthd -s 902"
    when "vnc"      then cmd_infix = "4 -P #{@pwds_file} -M #{@hosts_file} vnc -s 5900"
    end
    cmd = "#{cmd_prefix} #{cmd_infix} #{cmd_suffix}"
    run(cmd)
    clean_exit(@run_type)
  end

###############################################################################
# Exit method
###############################################################################
  # Parse and exit
  def clean_exit(search_term)
    Dir.chdir(@init_dir)
    if File.exist?(@out_file)
      results = open(@out_file) { |a| a.grep(/\[#{search_term}\]/) }
      if results.count == 0
        puts "Hydra did not find valid credentials.".light_yellow
      else
        puts "Hydra found the following credentials:".light_yellow
        puts results
      end
    end
    if File.exist?(@out_file)
      puts "Raw output can be found here:".yellow
      puts @out_file
    end
  exit_weapon
  end
end  
