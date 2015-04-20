# Author: p$3ud0R@nD0m

class HTTP < Menu
  def menu
    header
    puts "Select a tactic:".light_yellow
    puts "1.  ID supported SSL/TLS protcols, ciphers, etc. (TestSSLServer)"
    puts "2.  ID supported SSL/TLS protcols and ciphers (SSLScan)"
    puts "3.  ID supported HTTP methods (Nmap)"
    puts "4.  ID common vulns (Nikto)"
    puts "5.  Apache - Enum users (Apache-users)"
    puts "88. Back"
    puts "99. Exit Gladius"
    
    selection = gets.to_i
    case selection
    when 1 then TestSSLServer.new("HTTP", "TestSSLServer - ID Protcols and Ciphers").menu("basic")
    when 2 then SSLScan.new("HTTP", "SSLScan - ID Protcols and Ciphers").menu("common")
    when 3 then GNmap.new("HTTP", "Nmap - ID Supported HTTP Methods").menu("script_http_methods")
    when 4 then Nikto.new("HTTP", "Nikto - ID Common Web Vulns").menu("")
    when 5 then ApacheUsers.new("HTTP", "Apache-users - Enum Users").menu("enum")
    when 88 then GatherInfo.new("Information Gathering").menu
    when 99 then GExeption.new.exit_gladius
    else puts "Invalid selection.".red
      menu
    end
  end
end
