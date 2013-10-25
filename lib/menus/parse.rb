#!/usr/bin/env ruby

# Author: p$3ud0R@nD0m

require_relative 'menu'

class Parse < Menu
  
# ttd_2: modularize: split top to menu and bottom to tools
  def menu
    header
    puts "Select a task:".light_yellow
    puts "1.  Nmap XML > CSV spreadsheet (Gladius)"
    #puts "2.  Nmap XML > open ports text file (Gladius)"
    puts "88. Back"
    puts "99. Exit Gladius"
    sel = gets.to_i
    puts
    case sel
      when 1 then in_file_type = "nmap_xml"
        puts "Input the full path to your Nmap XML file and press 'Enter'.".light_yellow
        puts "Examples:".yellow
        puts "/usr/share/gladius/output/nmap_2013-10-11_23:32:03.xml".yellow
        puts "/root/Desktop/nmap_output.xml".yellow
      when 2 then in_file_type = "nmap_xml"
        puts "Input the full path to your Nmap XML file and press 'Enter'.".light_yellow
        puts "Examples:".yellow
        puts "/usr/share/gladius/output/nmap_2013-10-11_23:32:03.xml".yellow
        puts "/root/Desktop/nmap_output.xml".yellow
      when 88 then MiscScripts.new("Miscellaneous scripts").menu
      when 99 then
        begin
          puts "Exiting Gladius. Have a bloody day!".red
          puts
        rescue Interrupt
        end
      else
        puts "Invalid selection.".red
        menu
    end
    puts
    in_file = gets.chomp.to_s
    if File.exist?(in_file)
      begin
        NmapParser.new(in_file).open_ports_csv
        puts
        menu
      rescue
        GExeption.new.home
      end
    else
      puts in_file + " does not exist".red
      menu
    end
  rescue Interrupt
    GExeption.new.exit_gladius
  end
end
