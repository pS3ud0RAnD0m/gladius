# Author: p$3ud0R@nD0m

require_relative 'menu'

class HTTP < Menu
  def menu
    header
    puts "Select an option:".light_yellow
    puts "1.  ID supported SSL/TLS protcols and ciphers (SSLScan)"
    puts "2.  ID supported HTTP methods (Nmap)"
    puts "3.  ID common vulns (Nikto)"
    puts "4.  Apache - Enum users (Apache-users)"
    puts "88. Back"
    puts "99. Exit Gladius"
    selection = gets.to_i
    case selection
      when 1 then SSLScan.new("HTTP", "SSLScan - ID Protcols and Ciphers").menu("common")
      when 2 then GNmap.new("HTTP", "Nmap - ID Supported HTTP Methods").menu("script_http_methods")
      when 3 then Nikto.new("HTTP", "Nikto - ID Common Web Vulns").menu("")
      when 4 then ApacheUsers.new("HTTP", "Apache-users - Enum Users").menu("enum")
      when 88 then GatherInfo.new("Information Gathering").menu
      when 99 then GExeption.new.exit_gladius
      else puts "Invalid selection.".red
        menu
    end
  end
end
