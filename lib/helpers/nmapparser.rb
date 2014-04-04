# Author: p$3ud0R@nD0m

# This script uses ruby-nmap-parser-0.3.5
# For more information go to http://rubynmap.sourceforge.net.
# The license is located at gladius/lib/helpers/thirdparty/ruby-nmap-parser/LICENSE.

require_relative 'thirdparty/ruby-nmap-parser/lib/nmap/parser'

class NmapParser
  def initialize(prev_menu, nmap_xml_file)
    @prev_menu = prev_menu
    @nmap_xml_file = nmap_xml_file
    @nmap_base_name = @nmap_xml_file.to_s.gsub(/.xml/, '') 
    @out_file = @nmap_base_name + ".csv"
    @nmap_exit_status = 1
  end

  # Check for complete XML file
  def check_xml
    nmap_xml_file = @nmap_xml_file
    @nmap_exit_status = `grep "Nmap done" #{nmap_xml_file} |wc -l`.to_i
    if @nmap_exit_status == 0
      puts "Incomplete Nmap XML file detected. Gladius will not parse it.".red
    end
  end

  def all_to_csv
    check_xml
    if @nmap_exit_status == 1
      puts "Parsing XML ...".yellow
      parser = Nmap::Parser.parsefile(@nmap_xml_file)
      File.open(@out_file, "w") do |line|
        line.puts "IP,Hostname,Port/Protocol"
        parser.hosts("up") do |host|
          addr = host.addr
          hostname = host.hostname.to_s
          [:any].each do |type| # tcp and udp is causing dup output
            host.getports("any") do |port|
              service = port.service
              service_info = ",#{port.num}/#{port.proto},#{port.state}"
              if service.name
                service_info = ",#{port.num}/#{port.proto},#{service.name},#{port.state}"
              else
                service_info = ",#{port.num}/#{port.proto},#{port.state}"
              end
              if service.product
                if service.version
                  service_info = ",#{port.num}/#{port.proto},#{service.name},#{service.product},#{service.version},#{port.state}"
                else
                  service_info = ",#{port.num}/#{port.proto},#{service.name},#{service.product},,#{port.state}"
                end
              else
                service_info = ",#{port.num}/#{port.proto},#{service.name},#{port.state}"
              end
              line.puts addr + "," + hostname + service_info
            end
          end
        end
      end
      puts "An Excel-ready file has been parsed and put here:".light_yellow
      puts @out_file
    end
  rescue
    GExeption.new.exit_weapon("Parser", @prev_menu)
  end
end
