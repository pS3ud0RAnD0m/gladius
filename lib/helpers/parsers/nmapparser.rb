#!/usr/bin/env ruby

# Author: p$3ud0R@nD0m

# This script uses ruby-nmap-parser-0.3.5
# For more information go to http://rubynmap.sourceforge.net.
# The license is located at gladius/lib/helpers/parsers/ruby-nmap-parser/LICENSE.

require_relative 'ruby-nmap-parser/lib/nmap/parser'

class NmapParser
  def initialize(nmap_xml_file)
    @nmap_xml_file = nmap_xml_file
    @nmap_base_name = @nmap_xml_file.to_s.gsub(/.xml/, '') 
    @tmp_file = @nmap_base_name + "_tmp.xml"
    @out_file = @nmap_base_name + ".csv"
  end

  # To ensure "open|filtered" states are not considered "open", this method creates a
  # temp xml file and changes the spelling of "open|f" to "opn|f" w/in the temp file.
  # Finally, the temp file is deleted.
  def open_filtered
    FileUtils.cp @nmap_xml_file, @tmp_file
    text = File.read(@tmp_file)
    output_of_gsub = text.gsub("open|f", "opn|f")
    File.open(@tmp_file, "w") {|file| file.puts output_of_gsub}
    puts
  end

  def open_ports_csv
    open_filtered
    parser = Nmap::Parser.parsefile(@tmp_file)
    File.open(@out_file, "w") do |a|
      a.puts "Open ports from " + @nmap_xml_file
      parser.hosts("up") do |host|
        addr = host.addr
        if host.hostname
          hostname = host.hostname.to_s
        else
          hostname = "nohostname"
        end
        [:tcp, :udp].each do |type|
          host.getports(type, "open") do |port|
            service = port.service
            service_info = ",#{port.num}/#{port.proto}"
            if service.name
              service_info = ",#{port.num}/#{port.proto},#{service.name}"
            end
            if service.product
              service_info = ",#{port.num}/#{port.proto},#{service.name},#{service.product}"
            end
            if service.version
              service_info = ",#{port.num}/#{port.proto},#{service.name},#{service.product} #{service.version}"
            end
            a.puts addr + "," + hostname + service_info
          end
        end
      end
    end
    File.delete(@tmp_file)
  end

# ttd_1: add this human friendly output option
  def open_ports
    parser = @parser
    puts "Nmap args: #{parser.session.scan_args}"
    puts "Runtime: #{parser.session.scan_time} seconds"
    puts
    File.open(@tmp_file, "w") do |a|
      d = `printf "Only showing open ports.\n\n"`
      a.puts d
      
      parser.hosts("up") do |host|
        b = host.addr
        #a.puts b
        [:tcp, :udp].each do |type|
          host.getports(type, "open") do |port|
            # awk |sort |uniq; then blah ...
            service = port.service
            c = ",#{port.num}/#{port.proto}"
            if service.name
              c = ",#{port.num}/#{port.proto},#{service.name}"
            end
            if service.product
              c = ",#{port.num}/#{port.proto},#{service.name},#{service.product}"
            end
            if service.version
              c = ",#{port.num}/#{port.proto},#{service.name},#{service.product} #{service.version}"
            end
            a.puts b + c
          end
        end
        a.puts
      end
    end
    tmp_file = @tmp_file
    out_file = @out_file
    #parsed = `grep -B1 open #{tmp_file} >#{out_file}`
    #d = `printf "Only showing open ports.\n\n"`
    
    parsed = `cat #{tmp_file} >>#{out_file}`
    File.delete(@tmp_file)
  end
end

