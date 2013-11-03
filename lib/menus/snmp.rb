# Author: p$3ud0R@nD0m

require_relative 'menu'

class SNMP < Menu
  def menu
    header
    puts "Select an option:".light_yellow
    puts "1.  Discover common community strings (Nmap)"
    puts "88. Back"
    puts "99. Exit Gladius"
    sel = gets.to_i
    puts
    if sel == 1
      GNmap.new("SNMP", "Nmap - Discover SNMP Community Strings").menu("script_snmp_dictionary")
    elsif sel == 88
      GNmap.new("Information Gathering").menu
    elsif sel == 99
      begin
      puts "Exiting Gladius. Have a bloody day!".red
      puts
      rescue Interrupt
      end
    else
      puts "Invalid selection.".red
      menu
    end
  end
end
