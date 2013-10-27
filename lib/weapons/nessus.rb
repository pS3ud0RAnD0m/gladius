#!/usr/bin/env ruby

# Author: p$3ud0R@nD0m

# ttd_3: if offering nessus support, we need to check for it's existence. 
class Nessus < Weapon
  def initialize(title)
    @title = title
    # Path variables
    @@path = "/opt/nessus/bin/nasl"
    @@path_module = "/opt/nessus/lib/nessus/plugins/ftp_anonymous.nasl"
    @@hosts = []
    # Variables for timestamping out files and child pid files
    @@time = Time.now
    @@out_file_tstamp = @@time.year.to_s + "-" + @@time.mon.to_s + "-" + @@time.day.to_s + \
                  "_" + @@time.hour.to_s + ":" + @@time.min.to_s + ":" + @@time.sec.to_s
    @@out_file = "/usr/share/gladius/output/nessus_" + @@out_file_tstamp + ".txt"
    @@pid_tstamp = "%10.10f" % @@time.to_f
    @@pid_file = "/usr/share/gladius/tmp/pids/" + @@pid_tstamp
  end

  def header_nessus
    header
    puts "CIDRs and ranges entered into NASLs are very slow, so you should only input hosts that are listening on the appropriate port.".yellow
    puts
    instruct_input_targets("fqdn", "ip")
  end

  def clean_exit
    if File.exists?(@@pid_file)
      pid = File.read(@@pid_file)
      `kill -9 #{pid}`
      File.delete(@@pid_file)
    end
    puts
    FTP.new("Gather Information - FTP").menu
  rescue Interrupt
    puts
    puts "Exiting Gladius. Have a bloody day!".red
    begin
      Kernel.exit
    rescue Exception => e
    puts
    end
  end
  
  def resc
    puts
    puts "Discovery stopped due to interrupt.".red
    clean_exit
  end
  
  # Parse and display results
  #def results(search_term)
  def results
    puts
    out_file = @@out_file
    #rslt = open(@@out_file) { |a| a.grep(/\[#{search_term}\]/) }
    #if rslt.count == 0
    #  puts "Nessus did not find valid credentials.".light_yellow
    #else
    #  puts "Nessus found the following credentials:".light_yellow
    #  puts rslt
    #end
    #puts
    puts "Raw output can be found here:".yellow
    puts out_file
  end
  
  # Discover anonymous FTP read/write logins:
  def ftp_anon
    header_nessus
    while line = gets
      @@hosts << line.chomp
    end
    if @@hosts.count == 0
      puts "No targets were input.".red
      puts
      menu
    elsif @@hosts.count == 1
      puts "Discovering anonymous FTP logins against 1 target ..."
      puts
    else
      hosts_count = @@hosts.count.to_s
      puts "Discovering anonymous FTP logins against " + hosts_count + " targets ..."
      puts
    end
    @@hosts.each do |host|
      x = Gpty.new
      x.time = @@pid_tstamp
      x.cmd = @@path + " -a -t " + host + " " + @@path_module + " |tee " + @@out_file
      x.shell
      results
    end
    clean_exit
  rescue Interrupt
    resc
  end
end  
