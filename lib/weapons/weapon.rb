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

  # Supply examples for weapon input.
  def instruct_input_targets(*args)
    puts "Input target(s), one per line:".light_yellow
    puts "When done, ensure the last line is blank and press Ctrl+D.".yellow
    if args.count == 1
      puts "Example:".yellow
    else
      puts "Examples:".yellow
    end
    args.each do |target_type|
      case target_type
      when "cidr" then puts "10.0.0.0/24".yellow
      when "domain" then puts "victima.com".yellow
      when "fqdn" then puts "www.victima.com".yellow
      when "fqdnp" then puts "www.victima.com:8443".yellow
      when "fqdnp_spaced" then puts "www.victima.com 8443".yellow
      when "ip" then puts "10.0.0.1".yellow
      when "ipp" then puts "10.0.0.1:8443".yellow
      when "ipp_spaced" then puts "10.0.0.1 8443".yellow
      when "ipr" then puts "10.0.0.0-100".yellow
      when "iprl" then puts "10.0.0.0-10.0.0.100".yellow
      when "iprf" then puts "10.0.0-2.0-100".yellow
      when "url" then puts "https://www.victima.com/".yellow
      end
    end
  end

  # Supply examples for single target weapon input.
  def instruct_input_target(*args)
    puts "Input a single target and press Enter:".light_yellow
    if args.count == 1
      puts "Example:".yellow
    else
      puts "Examples:".yellow
    end
    args.each do |target_type|
      case target_type
      when "cidr" then puts "10.0.0.0/24".yellow
      when "domain" then puts "victima.com".yellow
      when "fqdn" then puts "www.victima.com".yellow
      when "fqdnp" then puts "www.victima.com:8443".yellow
      when "fqdnp_spaced" then puts "www.victima.com 8443".yellow
      when "ip" then puts "10.0.0.1".yellow
      when "ipp" then puts "10.0.0.1:8443".yellow
      when "ipp_spaced" then puts "10.0.0.1 8443".yellow
      when "ipr" then puts "10.0.0.0-100".yellow
      when "iprl" then puts "10.0.0.0-10.0.0.100".yellow
      when "iprf" then puts "10.0.0-2.0-100".yellow
      when "url" then puts "https://www.victima.com/".yellow
      end
    end
  end
  
  def instruct_input_pwds(service)
    puts "Input password(s), one per line:".light_yellow
    puts "When done, ensure the last line is blank and press Ctrl+D.".yellow
    puts "Examples:".yellow
    case service
    when "ftp" then
      puts "password".yellow
      puts "FTPPassword".yellow    
    when "mssql" then
      puts "password".yellow
      puts "mssqlpass".yellow
    when "mysql" then
      puts "password".yellow
      puts "mysqlpass".yellow
    when "postgres" then
      puts "password".yellow
      puts "postgrespass".yellow
    when "ssh" then
      puts "password".yellow
      puts "toor".yellow
    when "telnet" then
      puts "password".yellow
      puts "cisco".yellow
    when "vnc" then
      puts "vncPassword!".yellow
      puts "$3cret".yellow
    when "windows" then
      puts "Password!".yellow
      puts "$3cret".yellow
    end
  end

  def instruct_input_pwds_list
    puts "Input your password file and press Enter.".light_yellow
    puts "Example:".yellow
    puts "/root/Desktop/passwords.txt".yellow
  end
  
  def instruct_input_usrs(service)
    puts "Input user(s), one per line:".light_yellow
    puts "When done, ensure the last line is blank and press Ctrl+D.".yellow
    puts "Examples:".yellow
    case service
    when "ftp" then
      puts "root".yellow
      puts "ftp".yellow    
    when "mssql" then
      puts "sa".yellow
      puts "dbadmin".yellow
    when "mysql" then
      puts "root".yellow
      puts "mysql".yellow
    when "postgres" then
      puts "postgres".yellow
      puts "admin".yellow
      puts "root".yellow
    when "ssh" then
      puts "root".yellow
      puts "www".yellow
    when "telnet" then
      puts "root".yellow
      puts "cisco".yellow
    when "windows" then
      puts "administrator".yellow
      puts "backups".yellow
    end
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
    puts "Input the path to your wordlist and press Enter.".light_yellow
    puts "Example:".yellow
    puts "/root/Desktop/words.txt".yellow
  end

# ttd_3: move this pid method to path.rb and refactor
  def get_pid_file
    time = Time.now
    tmp_pids = Path.get("share_pids")
    pid_tstamp = "%10.10f" % time.to_f
    time.strftime(tmp_pids + pid_tstamp + ".pid")
  end

  def get_tmp_file
    time = Time.now
    tmp_file = Path.get("share_tmp")
    file_tstamp = "%10.10f" % time.to_f
    time.strftime(tmp_file + file_tstamp + ".tmp")
  end
  
  def get_port(default)
    puts "Input target port: [#{default}]".light_yellow
    @port = gets.chomp
    if @port.empty?
      @port = default
    end
  end
  
  # Get input and validate not empty
  def get_input(type, destination)
    case type
    when "stdin_to_file" then
      a = File.open(destination, "w")
      while line = gets
        a << line
      end
      a.close
      line_count = count_lines_file(destination)
      while line_count == 0
        no_input
        a = File.open(destination, "w")
        while line = gets
          a << line
        end
        a.close
        line_count = count_lines_file(destination)
      end
    when "gets_to_var" then
      destination = gets.chomp
      line_count = count_lines_file(destination)
      while line_count == 0
        puts "File is empty or does not exist.".red
        destination = gets.chomp
        line_count = count_lines_file(destination)
      end
      @share_seed = destination
    end
  end

  def get_input_file
    @file = gets.chomp
    if @file.empty?
      no_input
      get_input_file
    end
  end

  def no_input
    puts "No input detected. Try again.".red
  end

  # Get wordlist counts
# ttd_1: convert count usage to count_lines_file
  def count(usrs_file, pwds_file)
    usrs_count = File.foreach(usrs_file).count.to_i
    pwds_count = File.foreach(pwds_file).count.to_i + 2
    total_count = usrs_count * pwds_count
    puts "1. #{total_count} attempts/host = #{usrs_count} users * #{pwds_count} passwords"
  end

# ttd_1: Replace all "wc -l" with this to handle final newlines.
  def count_lines_file(file_name)
    if File.exist?(file_name)
      count = `sed -n '=' #{file_name} |wc -l`.to_i
    else
      count = 0
      puts "No input detected.".red
    end
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
    puts
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
