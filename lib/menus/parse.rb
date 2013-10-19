#!/usr/bin/env ruby

# Author: p$3ud0R@nD0m

require_relative 'menu'

class Parse < Menu
  def menu
    header
    puts "Select a file type to parse:".light_yellow
    puts "1.  Nmap XML"
    puts "88. Back"
    puts "99. Exit Gladius"
    sel = gets.to_i
    puts
    case sel
      when 1 then in_file_type = "nmap_xml"
        puts "Input the full path to your Nmap XML file and press 'Enter'.".light_yellow
        puts "Example:".yellow
        puts "/root/Desktop/nmap_output.xml".yellow
      when 88 then KaliServices.new.menu
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
    begin
      NmapParser.new(in_file).open_ports_csv
      puts "An Excel-ready file showing only open ports has been parsed and put here:".light_yellow
      out_file = in_file.gsub(/xml/, 'csv') 
      puts out_file
      puts
    rescue Exception => e
    end
  KaliServices.new("Configure Kali Services").menu
  rescue Interrupt
    GExeption.new.exit_gladius
  end
end


