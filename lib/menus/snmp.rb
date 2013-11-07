# Author: p$3ud0R@nD0m

require_relative 'menu'

class SNMP < Menu
  def menu
    header
    puts "Select an option:".light_yellow
    puts "1.  Discover common community strings (Nmap)"
    puts "88. Back"
    puts "99. Exit Gladius"
    selection = gets.to_i
    case selection
      when 1 then GNmap.new("SNMP", "Nmap - Discover SNMP Community Strings").menu("script_snmp_dictionary")
      when 88 then GatherInfo.new("Information Gathering").menu
      when 99 then GExeption.new.exit_gladius
      else puts "Invalid selection.".red
        menu
    end
  end
end