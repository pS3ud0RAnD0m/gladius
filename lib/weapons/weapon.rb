# Author: p$3ud0R@nD0m

class Weapon
  def initialize
    @host = host
    @hosts = []
    @port = port
    @ports = []
    @hosts_ports = []
  end

  def header
    puts "----------------------------------------"
    puts @title
    puts "----------------------------------------"
  end

  def get_pid_file
    time = Time.now
    tmp_pids = Path.get("share_pids")
    pid_tstamp = "%10.10f" % time.to_f
    time.strftime(tmp_pids + pid_tstamp + ".pid")
  end

  def get_host
    puts "Input target port number: [localhost:)]".light_yellow
    @host = gets.chomp
    if @host.empty?
      @host = "localhost"
    end
  end
  
  def get_port(default)
    puts "Input target port: [#{default}]".light_yellow
    @port = gets.chomp
    if @port.empty?
      @port = default
    end
  end
  
  def get_hosts_ports
    while line = gets
      @hosts_ports << line.chomp
    end
  end

  # Supply examples for weapon input.
  def instruct_input_targets(*args)
    puts "Input target(s), one per line:".light_yellow
    puts "When done, ensure the last line is blank and press Ctrl+D.".yellow
    if args.count == 1
      puts "Example:".yellow
    else
      puts "Examples:".yellow
    end
    args.each do |a|
      if a == "cidr"
        puts "10.0.0.0/24".yellow
      end
      if a == "domain"
        puts "victima.com".yellow
      end
      if a == "fqdn"
        puts "www.victima.com".yellow
      end
      if a == "fqdnp"
        puts "www.victima.com:8443".yellow
      end
      if a == "fqdnp_spaced"
        puts "www.victima.com 8443".yellow
      end
      if a == "ip"
        puts "10.0.0.1".yellow
      end
      if a == "ipp"
        puts "10.0.0.1:8443".yellow
      end
      if a == "ipp_spaced"
        puts "10.0.0.1 8443".yellow
      end
      if a == "ipr"
        puts "10.0.0.0-100".yellow
      end
      if a == "iprl"
        puts "10.0.0.0-10.0.0.100".yellow
      end
      if a == "iprf"
        puts "10.0.0-2.0-100".yellow
      end
      if a == "url"
        puts "https://www.victima.com/".yellow
      end
    end
  end
  
  def instruct_input_pwds
    puts "Input password(s), one per line:".light_yellow
    puts "When done, ensure the last line is blank and press Ctrl+D.".yellow
    puts "Examples:".yellow
  end

  def instruct_input_pwds_list
    puts "Input your password file and press Enter.".light_yellow
    puts "Example:".yellow
    puts "/root/Desktop/passwords.txt".yellow
  end
  
  def instruct_input_usrs
    puts "Input user(s), one per line:".light_yellow
    puts "When done, ensure the last line is blank and press Ctrl+D.".yellow
    puts "Examples:".yellow
  end

  def instruct_input_usrs_list
    puts "Input your user file and press Enter.".light_yellow
    puts "Example:".yellow
    puts "/root/Desktop/users.txt".yellow
  end
  
  def instruct_input_words
    puts "Input word(s), one per line:".light_yellow
    puts "When done, ensure the last line is blank and press Ctrl+D.".yellow
    puts "Examples:".yellow
    puts "acme".yellow
    puts "acmeadmin".yellow
  end

  def instruct_input_words_list
    puts "Input your word list and press Enter.".light_yellow
    puts "Example:".yellow
    puts "/root/Desktop/words.txt".yellow
  end

  # Get input and validate not empty
  def get_input(type, instruct_type, destination)
    case type
    when "stdin_to_file" then
      instruct_input = "instruct_input_" + instruct_type
      send(instruct_input)
      a = File.open(destination, "w")
      while line = gets
        a << line
      end
      a.close
      line_count = count_lines_file(destination)
      while line_count == 0
        no_input
        send(instruct_input)
        a = File.open(destination, "w")
        while line = gets
          a << line
        end
        a.close
        line_count = count_lines_file(destination)
      end
# ttd_1: gets_to_var input validation needs flushed out further
    when "gets_to_var" then
      instruct_input = "instruct_input_" + instruct_type
      send(instruct_input)
      destination = gets
      line_count = count_lines_file(destination)
      while line_count == 0
        puts "#{destination} is empty.".red
        send(instruct_input)
        destination = gets
        line_count = count_lines_file(destination)
      end
    end
  end
  def no_input
    puts "No input detected.".red
  end

  # Get wordlist counts
# ttd_1: convert count usage to count_lines
  def count(usrs_file, pwds_file)
    usrs_count = File.foreach(usrs_file).count.to_i
    pwds_count = File.foreach(pwds_file).count.to_i + 2
    total_count = usrs_count * pwds_count
    puts "1. #{total_count} attempts/host = #{usrs_count} users * #{pwds_count} passwords"
  end

# ttd_2: Replace all "wc -l" with this to handle final newlines.
  def count_lines_file(file_name)
    count = %x{sed -n '=' #{file_name} | wc -l}.to_i
  end
  
  def count_pwds_file(pwds_file)
    pwds_count = File.foreach(pwds_file).count.to_i + 2
    puts "1. #{pwds_count} attempts/host = #{pwds_count} passwords"
  end

  def run(cmd)
    pid_file = get_pid_file
    x = Gpty.new
    x.pid_file = pid_file
    x.cmd = cmd
    x.shell
    if File.exists?(pid_file)
      File.delete(pid_file)
    end
  rescue Interrupt
    puts
    puts "Stopped due to interrupt.".red
    if File.exists?(pid_file)
      pid = File.read(pid_file)
      `kill -9 #{pid}`
      File.delete(pid_file)
    end
  end

  # Return to previous menu
  def exit_weapon
    case @prev_menu
    when "CustomDictionary" then CustomDictionary.new("Create Custom Dictionaries").menu
    when "DictionaryOnline" then DictionaryOnline.new("Online Dictionary Attacks").menu
    when "Dictionary" then Dictionary.new("Dictionary Attacks").menu
    when "DiscoverServices" then DiscoverServices.new("Nmap - Discover Services").menu
    when "DNS" then DNS.new("Gather Information - DNS").menu
    when "FTP" then FTP.new("Gather Information - FTP").menu
    when "GatherInfo" then GatherInfo.new("Gather Information").menu
    when "HTTP" then HTTP.new("Gather Information - HTTP(S)").menu
    when "KaliSupport" then KaliSupport.new("Kali Support").menu
    when "NetbiosSMB" then NetbiosSMB.new("Gather Information - Netbios-SMB").menu
    when "NetworkAttacks" then NetworkAttacks.new("Network Attacks").menu
    when "ParseFile" then ParseFile.new("Parse Files").menu
    when "SMTP" then SMTP.new("Gather Information - SMTP").menu
    when "SniffSpoof" then SniffSpoof.new("Sniffing and Spoofing").menu
    when "SNMP" then SNMP.new("Gather Information - SNMP").menu
    when "SnortService" then SnortService.new("Upgrade/Install Snort/Snorby and Start").install
    when "TFTP" then TFTP.new("Gather Information - TFTP").menu
    when "VPNAttacks" then VPNAttacks.new("VPN Attacks").menu
    end
  rescue Interrupt
    GExeption.new.exit_gladius
  end
# ttd_2: Add subbrute.py
end
