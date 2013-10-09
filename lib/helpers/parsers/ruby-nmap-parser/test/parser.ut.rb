#!/usr/bin/env ruby
#
# By Kris Katterjohn
# 06/18/2009
#

$:.push("../lib")

require 'test/unit'
require 'nmap/parser'

class Nmap::UnitTest::Parser < Test::Unit::TestCase
	def setup
		return if @othername

		@othername = "xml/other.xml"
		@otherfile = File.open(@othername)
		@otherstr = @otherfile.read
		@otherfile.rewind
	end

	def teardown
		@otherfile.close
	end

	def test_parsefile
		assert_raise(Errno::ENOENT) do
			Nmap::Parser.parsefile("nonexistent.xml")
		end

		p1 = nil
		p2 = nil

		assert_nothing_raised do
			p1 = Nmap::Parser.parsefile(@othername) do |p|
				p2 = p
			end
		end

		assert_instance_of(Nmap::Parser, p1)
		assert_same(p1, p2)
	end

	def test_parseread
		assert_raise(TypeError) do
			Nmap::Parser.parseread("fail")
		end

		p1 = nil
		p2 = nil

		assert_nothing_raised do
			p1 = Nmap::Parser.parseread(@otherfile) do |p|
				p2 = p
			end
		end

		assert_instance_of(Nmap::Parser, p1)
		assert_same(p1, p2)
	end

	def test_parsescan
		assert_raise(ArgumentError) do
			Nmap::Parser.parsescan("nmap", "-o somehost")
		end

		assert_raise(ArgumentError) do
			Nmap::Parser.parsescan("nmap", "-T4 -oX xml somehost")
		end

		p1 = nil
		p2 = nil

		assert_nothing_raised do
			p1 = Nmap::Parser.parsescan("sudo nmap", "-T4 -n localhost") do |p|
				p2 = p
			end
		end

		assert_instance_of(Nmap::Parser, p1)
		assert_same(p1, p2)
	end

	def test_parsestring
		assert_raise(TypeError) do
			Nmap::Parser.parsestring(666)
		end

		p1 = nil
		p2 = nil

		assert_nothing_raised do
			p1 = Nmap::Parser.parsestring(@otherstr) do |p|
				p2 = p
			end
		end

		assert_instance_of(Nmap::Parser, p1)
		assert_same(p1, p2)
	end

	def test_new
		assert_raise(NoMethodError) do
			Nmap::Parser.new(1337)
		end

		p1 = nil
		p2 = nil

		assert_nothing_raised do
			p1 = Nmap::Parser.new({}) do |p|
				p2 = p
			end
		end

		assert_instance_of(Nmap::Parser, p1)
		assert_same(p1, p2)
	end
end

