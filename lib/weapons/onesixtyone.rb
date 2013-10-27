#!/usr/bin/env ruby

# Author: p$3ud0R@nD0m

require 'weapon'

class Onesixtyone < Weapon
  def initialize(prev_menu, title)
    @prev_menu = prev_menu
    @title = title
    @path = "onesixtyone"
    @name = @path
    @hosts_file = Path.hosts_file
    @snmp_comm_strings_long = "/usr/share/gladius/input/snmp_comm_strings_long.txt"
  end

###############################################################################
# DRY methods
###############################################################################

  def menu(scan_type)
    header
    instruct_input_targets("ip")
    a = File.open(@@hosts, "w")
    while line = gets
      a << line
    end
    a.close
    hosts = @@hosts
    line_count = `wc -l #{hosts}`.to_i
    if line_count == 0
      puts "No hosts were input.".red
    else
      case scan_type
        when "dictionary_long" then dictionary_long
      end
    end
  rescue Interrupt
    GExeption.new.exit_weapon("Onesixtyone", @prev_menu)
  end

  # Parse and exit
  def clean_exit(search_term)
    puts
    out_file = @@out_file
    if File.exist?(@out_file)
      line_count = `wc -l #{out_file}`.to_i
      if line_count == 0
        puts "Onesixtyone did not find valid credentials.".light_yellow
      else
        puts "Onesixtyone found the following credentials:".light_yellow
        a = `cat #{out_file}`
        puts a
      end
      puts
      puts "Raw output can be found here:".yellow
      puts @out_file
    end
    puts
    case @prev_menu
      when "SNMP" then SNMP.new("Gather Information - SNMP").menu
    end
  rescue Interrupt
    GExeption.new.exit_gladius
  end

###############################################################################
# Dictionary methods
###############################################################################
  # Discover common community strings:
  def dictionary_long
    @out_file = get_out_file_txt(@name)
    cmd = @path + " -c " + @snmp_comm_strings_long + " -i #{hosts} -d -o " + @out_file
    run(cmd)
# ttd_1: search_term needs to be fixed. currently "public".
    clean_exit("public")
  end
end  
