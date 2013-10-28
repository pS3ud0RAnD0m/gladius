#!/usr/bin/env ruby
#
# By Kris Katterjohn
# 06/18/2009
#

$:.push("../lib")

require 'test/unit'
require 'nmap/parser'

class Nmap::UnitTest::LargeDotXml < Test::Unit::TestCase
	def setup
		@parser = Nmap::Parser.parsefile("xml/large.xml") unless @parser
	end

	def test_parser_obj
		assert_instance_of(Nmap::Parser, @parser)
	end

	def test_parser
		allips = @parser.get_ips

		assert_equal(6, @parser.hosts.size)
		assert_equal(@parser.hosts.size, allips.size)

		@parser.hosts("up") do |host|
			assert_equal("up", host.status)
			assert(allips.include?(host.ip4_addr))
		end

		assert_nil(@parser.host("nonexistent"))

		host = @parser.host("192.168.10.1")

		assert_instance_of(Nmap::Parser::Host, host)
		assert_equal("192.168.10.1", host.ip4_addr)
	end

	def test_session
		types = ["syn", "udp", "sctpinit"]

		session = @parser.session

		assert_equal(256, session.numhosts)
		assert_equal(6, session.numhosts("up"))
		assert_equal(250, session.numhosts("down"))

		scantypes = session.scan_types
		assert_equal(types.size, scantypes.size)

		types.each do |type|
			assert(scantypes.include?(type))
		end

		assert_equal(75, session.numservices)
		types.each do |type|
			assert_equal(25, session.numservices(type))
		end
		assert_equal(0, session.numservices("nonexistent"))

		assert_equal("tcp", session.scan_type_proto("syn"))
		assert_equal("udp", session.scan_type_proto("udp"))
		assert_equal("sctp", session.scan_type_proto("sctpinit"))
		assert_nil(session.scan_type_proto("nonexistent"))
	end

	def test_host_addrs
		@parser.hosts("up") do |host|
			case host.ip4_addr.split(/\./)[3].to_i
			when 1
				assert_equal("00:1A:70:F6:B3:E6", host.mac_addr)
				assert_equal("Cisco-Linksys", host.mac_vendor)
			when 2
				assert_equal("00:E0:11:05:DD:E9", host.mac_addr)
				assert_equal("Uniden", host.mac_vendor)
			when 5
				assert_equal("00:11:D8:47:95:3C", host.mac_addr)
				assert_equal("Asustek Computer", host.mac_vendor)
			when 8
				assert_equal("00:23:4D:A8:DD:4B", host.mac_addr)
				assert_equal("Hon Hai Precision Ind. Co.", host.mac_vendor)
			when 123
				assert_equal("00:0A:E4:87:EC:C0", host.mac_addr)
				assert_equal("Wistron", host.mac_vendor)
			else
				assert_nil(host.mac_addr)
				assert_nil(host.mac_vendor)
			end
		end
	end

	# XXX more hosts
	def test_host_timing
		host = @parser.host("192.168.10.6")

		times = host.times

		assert_equal(49, times.srtt)
		assert_equal(29, times.rttvar)
		assert_equal(100000, times.to)

		assert_equal(1245544544, host.starttime)
		assert_equal(1245544617, host.endtime)

		host = @parser.host("192.168.10.123")

		times = host.times

		assert_equal(16963, times.srtt)
		assert_equal(11015, times.rttvar)
		assert_equal(100000, times.to)

		assert_equal(1245544541, host.starttime)
		assert_equal(1245544812, host.endtime)
	end

	def test_host_sequences
		host = @parser.host("192.168.10.6")

		assert_equal(202, host.tcpsequence_index)
		assert_nil(host.tcpsequence_class)
		assert_equal("Good luck!", host.tcpsequence_difficulty)
		assert_equal("1D0723F0,1DC93932,1D8831B3,1DEAF74E,1D58C466,1E27B5D4", host.tcpsequence_values)

		assert_equal("All zeros", host.ipidsequence_class)
		assert_equal("0,0,0,0,0,0", host.ipidsequence_values)

		assert_equal("1000HZ", host.tcptssequence_class)
		assert_equal("122DD36,122DD9B,122DE00,122DE65,122DECA,122DF2F", host.tcptssequence_values)

		host = @parser.host("192.168.10.123")

		assert_equal(208, host.tcpsequence_index)
		assert_nil(host.tcpsequence_class)
		assert_equal("Good luck!", host.tcpsequence_difficulty)
		assert_equal("F0427613,F06069A3,F129EAA0,F049985D,F0621AFF,F13B8248", host.tcpsequence_values)

		assert_equal("All zeros", host.ipidsequence_class)
		assert_equal("0,0,0,0,0,0", host.ipidsequence_values)

		assert_equal("100HZ", host.tcptssequence_class)
		assert_equal("82B788,82B792,82B79C,82B7A6,82B7B1,82B7BB", host.tcptssequence_values)
	end

	def test_host_other
		host = @parser.host("192.168.10.6")

		assert_equal(19078, host.uptime_seconds)

		assert_equal(0, host.distance)

		host = @parser.host("192.168.10.123")

		assert_equal(85711, host.uptime_seconds)

		assert_equal(1, host.distance)
	end

	# I use the <proto>_port* methods here instead of the getport* methods
	# because the former ones simply call the latter so I can test both
	# here at the same time
	def test_ports
		@parser.hosts("up") do |host|
			["tcp", "udp", "sctp"].each do |type|
				["open", "closed", "filtered"].each do |state|
					host.send("#{type}_ports", state) do |port|
						assert_instance_of(Nmap::Parser::Host::Port, port)

						assert_equal(type, port.proto)

						host.send("#{type}_port", port.num) do |p|
							assert_same(p, port)
						end
					end
				end
			end
		end
	end

	def test_scripts
		# XXX
	end

	def test_os
		@parser.hosts("up") do |host|
			os = host.os
			assert(os)
			assert_match(/V=4.85BETA10/, os.fingerprint)

			os.osclasses.each_with_index do |osclass, index|
				assert_equal(osclass.ostype, os.ostype(index))
				assert_equal(osclass.osvendor, os.osvendor(index))
				assert_equal(osclass.osfamily, os.osfamily(index))
				assert_equal(osclass.osgen, os.osgen(index))

				assert_equal(osclass.accuracy, os.class_accuracy)
			end

			os.osmatches.each_with_index do |osmatch, index|
				assert_equal(osmatch.name, os.name)
				assert_equal(osmatch.accuracy, os.name_accuracy)
			end

			case host.addr
			when "192.168.10.6"
				assert_equal(21, os.tcpport_open)
				assert_equal(23, os.tcpport_closed)
				assert_equal(53, os.udpport_closed)

				assert_equal(1, os.class_count)

				osclass = os.osclasses[0]

				assert_equal("general purpose", osclass.ostype)
				assert_equal("Linux", osclass.osvendor)
				assert_equal("Linux", osclass.osfamily)
				assert_equal("2.6.X", osclass.osgen)
				assert_equal(100, osclass.accuracy)

				osmatch = os.osmatches[0]

				assert_match(/2\.6\.27/, osmatch.name)
				assert_equal(100, osmatch.accuracy)
			when "192.168.10.123"
				assert_equal(22, os.tcpport_open)
				assert_equal(21, os.tcpport_closed)
				assert_equal(53, os.udpport_closed)

				assert_equal(1, os.class_count)

				osclass = os.osclasses[0]

				assert_equal("general purpose", osclass.ostype)
				assert_equal("Linux", osclass.osvendor)
				assert_equal("Linux", osclass.osfamily)
				assert_equal("2.6.X", osclass.osgen)
				assert_equal(100, osclass.accuracy)

				osmatch = os.osmatches[0]

				assert_match(/2\.6\.28/, osmatch.name)
				assert_equal(100, osmatch.accuracy)
			end
		end
	end
end

