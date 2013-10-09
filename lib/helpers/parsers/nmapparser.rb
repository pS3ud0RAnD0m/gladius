#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

# This script uses ruby-nmap-parser-0.3.5
# For more information go to http://rubynmap.sourceforge.net.
# The license is located at gladius/lib/helpers/parsers/ruby-nmap-parser/LICENSE.

require_relative 'ruby-nmap-parser/lib/nmap/parser'

class NmapParser
  def initialize(nmap_xml_file)
    @@nmap_xml_file = nmap_xml_file
    @@parser = Nmap::Parser.parsefile(@@nmap_xml_file)
    @@tmp_file = "/usr/share/gladius/tmp/nmap_tmp.txt"
    @@out_file = @@nmap_xml_file + ".gladius"
  end

  def open_ports
    parser = @@parser
    puts "Nmap args: #{parser.session.scan_args}"
    puts "Runtime: #{parser.session.scan_time} seconds"
    puts
    File.open(@@tmp_file, "w") do |a|
      parser.hosts("up") do |host|
        b = "Host #{host.addr}"
        a.puts b
        [:tcp, :udp].each do |type|
          host.getports(type, "open") do |port|
            # awk |sort |uniq; then blah ...
            service = port.service
            c = "open #{port.num}/#{port.proto}"
            if service.name
              c = "open #{port.num}/#{port.proto} #{service.name}"
            end
            if service.product
              c = "open #{port.num}/#{port.proto} #{service.name} #{service.product}"
            end
            if service.version
              c = "open #{port.num}/#{port.proto} #{service.name} #{service.product} #{service.version}"
            end
            a.puts c
          end
        end
        a.puts
      end
    end
    tmp_file = @@tmp_file
    out_file = @@out_file
    parsed = `grep -B1 open #{tmp_file} >#{out_file}`
    File.delete(@@tmp_file)
  end
end

