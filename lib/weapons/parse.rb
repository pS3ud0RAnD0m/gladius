# Author: p$3ud0R@nD0m

class Parse < Weapon
  def initialize(prev_menu, title)
    @prev_menu = prev_menu
    @title = title
    @name = "Gladius Parser"
    @stdn_hosts = Path.get("share_stdn_hosts")
    @in_file = ""
  end

###############################################################################
# DRY methods
###############################################################################
  # Dry menu
  def menu(parse_type)
    header
    case parse_type
      when "nmap_xml_to_csv" then puts "Input the full path to your Nmap XML file and press <Enter>.".light_yellow
        puts "Examples:".yellow
        puts "/usr/share/gladius/output/nmap_2013-10-11_23-32-03.xml".yellow
        puts "/root/Desktop/nmap_output.xml".yellow
    end
    @in_file = gets.chomp.to_s
    if File.exist?(@in_file)
      nmap_xml_to_csv
    else
      in_file = @in_file
      puts "#{in_file} does not exist.".red
      menu(parse_type)
    end
  rescue Interrupt
    GExeption.new.exit_weapon("Parser", @prev_menu)
  end

  # Parse and exit
  def clean_exit
    exit_weapon
  end

###############################################################################
# Parse methods
###############################################################################
  # parse Nmap XML to Excel-ready CSV
  def nmap_xml_to_csv
    NmapParser.new(@prev_menu, @in_file).open_ports_csv
# ttd_2: parser interrupt gets processed, then this bc GExeption.exit_gladius isn't killing all off.
    clean_exit
  end  
end
