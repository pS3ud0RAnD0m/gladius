# Author: p$3ud0R@nD0m

class DiscoverServices < Menu
  def menu
    header
    puts "Select a scanning option:".light_yellow
    puts "Very Quick:".yellow
    puts "1.  ARP/ICMP/Web only"
    puts "2.  TCP top 25 ports (LAN)"
    puts "3.  TCP top 25 ports (WAN)"
    puts "Quick:".yellow
    puts "4.  TCP top 1000 ports"
    puts "5.  UDP top 1000 ports"
    puts "6.  TCP/UDP top 1000 ports"
    puts "Common:".yellow
    puts "7.  TCP top 1000 ports with versioning"
    puts "8.  UDP top 1000 ports with versioning"
    puts "9.  TCP/UDP top 1000 ports with versioning"
    puts "Detailed:".yellow
    puts "10. TCP top 1000 ports with versioning and scripts"
    puts "11. UDP top 1000 ports with versioning and scripts"
    puts "12. TCP/UDP top 1000 ports with versioning and scripts"
    puts "Thorough:".yellow
    puts "13. TCP all ports"
    puts "14. UDP all ports"
    puts "15. TCP/UDP all ports"
    puts "Other:".yellow
    puts "16. Custom scan"
    puts "88. Back"
    puts "99. Exit Gladius"
    
    selection = gets.to_i
    case selection
    when 1 then GNmap.new("DiscoverServices", "Nmap - ARP/ICMP/Web Only").menu("ping_discovery")
    when 2 then GNmap.new("DiscoverServices", "Nmap - TCP Top 25 Ports - LAN").menu("tcp_very_quick_lan")
    when 3 then GNmap.new("DiscoverServices", "Nmap - TCP Top 25 Ports - WAN").menu("tcp_very_quick_wan")
    when 4 then GNmap.new("DiscoverServices", "Nmap - TCP Top 1000 Ports").menu("tcp_quick")
    when 5 then GNmap.new("DiscoverServices", "Nmap - UDP Top 1000 Ports").menu("udp_quick")
    when 6 then GNmap.new("DiscoverServices", "Nmap - TCP/UDP Top 1000 Ports").menu("tcp_udp_quick")
    when 7 then GNmap.new("DiscoverServices", "Nmap - TCP Top 1000 Ports Versioning").menu("tcp_quick_v")
    when 8 then GNmap.new("DiscoverServices", "Nmap - UDP Top 1000 Ports Versioning").menu("udp_quick_v")
    when 9 then GNmap.new("DiscoverServices", "Nmap - TCP/UDP Top 1000 Ports Versioning").menu("tcp_udp_quick_v")
    when 10 then GNmap.new("DiscoverServices", "Nmap - TCP Top 1000 Ports with scripts").menu("tcp_quick_scripts")
    when 11 then GNmap.new("DiscoverServices", "Nmap - UDP Top 1000 Ports with scripts").menu("udp_quick_scripts")
    when 12 then GNmap.new("DiscoverServices", "Nmap - TCP/UDP Top 1000 Ports with scripts").menu("tcp_udp_quick_scripts")
    when 13 then GNmap.new("DiscoverServices", "Nmap - TCP All Ports").menu("tcp_full")
    when 14 then GNmap.new("DiscoverServices", "Nmap - UDP All Ports").menu("udp_full")
    when 15 then GNmap.new("DiscoverServices", "Nmap - TCP/UDP All Ports").menu("tcp_udp_full")
    when 16 then GNmap.new("DiscoverServices", "Nmap - Custom").menu("custom")
    when 88 then GatherInfo.new("Information Gathering").menu
    when 99 then GExeption.new.exit_gladius
    else puts "Invalid selection.".red
      menu
    end
  end
end
