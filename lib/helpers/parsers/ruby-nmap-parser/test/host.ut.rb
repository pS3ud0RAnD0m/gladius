#!/usr/bin/env ruby
#
# By Kris Katterjohn
# 06/18/2009
#

$:.push("../lib")

require 'test/unit'
require 'nmap/parser'

class Nmap::UnitTest::Host < Test::Unit::TestCase
	def setup
		@parser = Nmap::Parser.parsefile("xml/other.xml") unless @parser
	end

	def test_parser_obj
		assert_instance_of(Nmap::Parser, @parser)
	end

	def test_host
		@parser.hosts do |host|
			assert_raise(ArgumentError) do
				host.getport(:nada, 21)
			end
			assert_raise(ArgumentError) do
				host.getports(:nada, 'open')
			end
			assert_raise(ArgumentError) do
				# well, getportlist simply calls getports...
				host.getportlist(:nada, 'open')
			end
		end
	end
end

