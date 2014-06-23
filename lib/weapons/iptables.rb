# Author: p$3ud0R@nD0m

class IPtables < Weapon
  def initialize(prev_menu, title)
    # Common
    @name = self.class.to_s.downcase
    @path = @name
    @prev_menu = prev_menu
    @title = title
    # Weapon specific
    @gladius_iptables = Path.get("gladius_iptables")
    @gladius_iptables_logrotate = Path.get("gladius_iptables_logrotate")
    @system_iptables = Path.get("system_iptables")
    @system_iptables_log = Path.get("system_iptables_log")
    @system_iptables_logrotate = Path.get("system_iptables_logrotate")
  end

###############################################################################
# DRY methods
###############################################################################
  # Dry menu
  def menu(run_method)
    header
    case run_method
    when "list" then list
    when "config" then
      puts "This will create the files listed below, configure boot-time run and logging.".light_yellow
      puts "/etc/init.d/iptables".yellow
      puts "/var/log/iptables.log".yellow
      puts "/etc/logrotate.d/iptables".yellow
      puts "Do you want to continue? [Y/n]".light_yellow
      sel = gets.chomp.downcase
      if sel == "y" || sel.empty?
        config_existance
      elsif sel == "n"
        puts "Let's just look at the active rules then.".light_yellow
        list
      else
        puts "Invalid selection.".red
        menu("config")
      end
    end
  rescue Interrupt
    GExeption.new.exit_weapon("IPtables", @prev_menu)
  end

  # Parse and exit
  def clean_exit
    exit_weapon
  end

###############################################################################
# Run methods
###############################################################################
  # List ruleset
  def list
    cmd = @path + " -L -nv"
    run(cmd)
    clean_exit
  end

  # Confirm iptables overwrite
  def config_existance
    if File.exist?(@system_iptables)
      puts "/etc/init.d/iptables already exists. Do you want to overwrite it? [Y/n]".light_yellow
      sel = gets.chomp.downcase
      if sel == "y" || sel.empty?
        config    
      elsif sel == "n"
        puts "Let's just look at the active rules then.".light_yellow
        list
      else
        puts "Invalid selection.".red
        config_existance
      end
    else
      config
    end
  end

  # Configure ruleset
  def config
    system_iptables = @system_iptables
    system_iptables_log = @system_iptables_log
    system_iptables_logrotate = @system_iptables_logrotate
    puts "The current ruleset is ...".light_yellow
    cmd = "iptables -L -nv"
    run(cmd)
    FileUtils.cp @gladius_iptables, @system_iptables
    puts "Created #{system_iptables}".light_yellow
    FileUtils.cp @gladius_iptables_logrotate, @system_iptables_logrotate
    puts "Created #{system_iptables_logrotate}".light_yellow
    if !File.exists?(@system_iptables_log)
      FileUtils.touch(@system_iptables_log)
    end
    puts "Created #{system_iptables_log}".light_yellow
    cmd = "chmod 600 /var/log/iptables.log"
    run(cmd)
# ttd_2: only echo into rsyslog.conf when not there.
    cmd = "echo 'kern.warning /var/log/iptables.log' >>/etc/rsyslog.conf"
    run(cmd)
    cmd = "service rsyslog restart"
    run(cmd)
    cmd = "service iptables restart"
    run(cmd)
    puts "No output is expected.".yellow
    cmd = "update-rc.d iptables defaults"
    run(cmd)
    puts
    puts "The new ruleset is ...".light_yellow
    cmd = "iptables -L -nv"
    run(cmd)
    puts
    puts "All outbound traffic is permitted.".yellow
    puts "All interesting drops are being logged to /var/log/iptables.log".yellow
    puts "Logs are being rotated and zipped daily.".yellow
    puts "Seven (7) days of logs are being kept.".yellow
    puts "You can modify log rotation by editing /etc/logrotate.d/iptables.".yellow
    puts "You can modify rules by editing /etc/init.d/iptables, then running 'service iptables restart'.".yellow
    clean_exit
  end
end
