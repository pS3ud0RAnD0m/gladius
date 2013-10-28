# $Id: nmap-parser.gemspec 217 2010-06-02 02:37:15Z kjak $

require 'rubygems'
require 'lib/nmap/parser'

spec = Gem::Specification.new do |s|
	s.name = "nmap-parser"
	s.version = Nmap::Parser::Version
	s.description = "Nmap::Parser"
	s.summary = <<EOS
This library provides a Ruby interface to the Nmap Security Scanner and its
XML formatted scan data.  It can run Nmap and parse its XML output directly
from the scan, parse a file or string of XML scan data, or parse XML scan
data from an object via its read() method.  This information is presented in
an easy-to-use and intuitive fashion for further storage and manipulation.
EOS

	s.files = [
		"BUGS",
		"ChangeLog.rdoc",
		"LICENSE",
		"README",
		"TODO",
		"lib/nmap/parser.rb"
	] + Dir["examples/*"]

	s.require_path = "lib"

	s.has_rdoc = true

	s.extra_rdoc_files = [ "ChangeLog.rdoc" ]

	s.author = "Kris Katterjohn"
	s.email = "katterjohn@gmail.com"

	s.homepage = "http://rubynmap.sourceforge.net"

	s.rubyforge_project = "rubynmap"
end

