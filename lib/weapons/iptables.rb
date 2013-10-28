# Author: p$3ud0R@nD0m

class IPtables < Weapon
  def initialize(title)
    @title = title
    @path = "iptables"
    
    #@gladius_iptables = Path.get_path("gladius_iptables")
    #@system_iptables = Path.get_path("system_iptables")
    @path_giptables = Constant::PROJECT_ROOT + "/helpers/input/iptables"
    @path_kiptables = "/etc/init.d/iptables"
  end

  # Check the status of iptables config
  def status
    puts
    header
    if File.exist?(@path_kiptables)
      puts "/etc/init.d/iptables already exists. Do you want to overwrite it? [Y/n]".light_yellow
      sel = gets.chomp
      if sel.downcase == "y" || sel.empty?
        config
      elsif sel.downcase == "n"
        puts "Let's just look at the active rules then.".light_yellow
        i = Gpty.new
        i.cmd = @path + " -L -nv"
        i.shell
        puts
        KaliSupport.new("Configure Kali Services").menu
      else
        puts "Invalid selection.".red
        status
      end
    else
      puts "it's already there".red
    end
  end
    
  # Configure ruleset
  def config
    path_giptables = @path_giptables
    path_kiptables = @path_kiptables
    a = Gpty.new
    puts "The current ruleset is:".light_yellow
    a.cmd = "iptables -L -nv"
    a.shell
    a.cmd = "cp #{path_giptables} #{path_kiptables}"
    a.shell
    a.cmd = "touch /var/log/iptables.log"
    a.shell
    a.cmd = "chmod 600 /var/log/iptables.log"
    a.shell
    a.cmd = "echo 'kern.warning /var/log/iptables.log' |cat >> /etc/rsyslog.conf"
    a.shell
    a.cmd = "service rsyslog restart"
    a.shell
    a.cmd = "service iptables restart"
    a.shell
    a.cmd = "update-rc.d iptables defaults"
    a.shell
    puts "The new ruleset is:".light_yellow
    a.cmd = "iptables -L -nv"
    a.shell
    puts
    puts "All outbound traffic is permitted.".light_yellow
    puts "All interesting drops are being logged to /var/log/iptables.log".light_yellow
    puts "You can modify the rules by editing /etc/init.d/iptables, then running 'service iptables restart'.".light_yellow
    puts
    KaliSupport.new("Configure Kali Services").menu
  end
  
  # List ruleset
  def list
    header
    i = Gpty.new
    i.cmd = @path + " -L -nv"
    i.shell
    puts
    KaliSupport.new("Configure Kali Services").menu
  end
end
