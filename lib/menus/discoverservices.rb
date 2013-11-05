# Author: p$3ud0R@nD0m

require_relative 'menu'

class DiscoverServices < Menu
  def menu
    header
    puts "Select a scanning option:".light_yellow
    puts "Quick Discovery:".yellow
    puts "1.  ARP/ICMP ping only"
    puts "2.  TCP top 25 ports (LAN)"
    puts "3.  TCP top 25 ports (WAN)"
    puts "Common Discovery:".yellow
    puts "4.  TCP top 1000 ports"
    puts "5.  UDP top 1000 ports"
    puts "6.  TCP/UDP top 1000 ports"
    puts "Detailed Discovery:".yellow
    puts "7.  TCP top 1000 ports with scripts"
    puts "8.  UDP top 1000 ports with scripts"
    puts "9.  TCP/UDP top 1000 ports with scripts"
    puts "Thorough Discovery:".yellow
    puts "10. TCP all ports"
    puts "11. UDP all ports"
    puts "12. TCP/UDP all ports"
    puts "Other:".yellow
    puts "13. Custom scan"
    puts "88. Back"
    puts "99. Exit Gladius"
    selection = gets.to_i
    case selection
      when 1 then GNmap.new("DiscoverServices", "Nmap - ARP/ICMP Ping Only").menu("ping_discovery")
      when 2 then GNmap.new("DiscoverServices", "Nmap - TCP Top 25 Ports - LAN").menu("tcp_very_quick_lan")
      when 3 then GNmap.new("DiscoverServices", "Nmap - TCP Top 25 Ports - WAN").menu("tcp_very_quick_wan")
      when 4 then GNmap.new("DiscoverServices", "Nmap - TCP Top 1000 Ports").menu("tcp_quick")
      when 5 then GNmap.new("DiscoverServices", "Nmap - UDP Top 1000 Ports").menu("udp_quick")
      when 6 then GNmap.new("DiscoverServices", "Nmap - TCP/UDP Top 1000 Ports").menu("tcp_udp_quick")
      when 7 then GNmap.new("DiscoverServices", "Nmap - TCP Top 1000 Ports with scripts").menu("tcp_quick_scripts")
      when 8 then GNmap.new("DiscoverServices", "Nmap - UDP Top 1000 Ports with scripts").menu("udp_quick_scripts")
      when 9 then GNmap.new("DiscoverServices", "Nmap - TCP/UDP Top 1000 Ports with scripts").menu("tcp_udp_quick_scripts")
      when 10 then GNmap.new("DiscoverServices", "Nmap - TCP All Ports").menu("tcp_full")
      when 11 then GNmap.new("DiscoverServices", "Nmap - UDP All Ports").menu("udp_full")
      when 12 then GNmap.new("DiscoverServices", "Nmap - TCP/UDP All Ports").menu("tcp_udp_full")
      when 13 then GNmap.new("DiscoverServices", "Nmap - Custom").menu("custom")
      when 88 then GatherInfo.new("Information Gathering").menu
      when 99 then GExeption.new.exit_gladius
      else puts "Invalid selection.".red
        menu
    end
  end
end
