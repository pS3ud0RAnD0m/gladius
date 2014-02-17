# Author:  p$3ud0R@nD0m

class Atftpd < Weapon
  def initialize(prev_menu, title)
    @prev_menu = prev_menu
    @title = title
    @path = "atftpd"
    @name = @path
  end

###############################################################################
# DRY methods
###############################################################################
  # Dry menu
  def menu(run_method)
    header
    # ID if IPtables is configed to drop anything
    drop_status = `iptables -L INPUT -nv |grep DROP`.chomp
    unless drop_status.empty?
      tftp_rule_status = `iptables -L INPUT -nv |grep "udp dpt:69" |grep ACCEPT`
      unless tftp_rule_status.empty?
        puts "Inbound TFTP rule detected. The firewall looks good.".light_yellow
        puts tftp_rule_status
        config
      else
        puts "IPtables' INPUT chain is dropping.".light_yellow
        puts "Inbound TFTP rule not detected. Please verify your firewall settings.".light_yellow
        puts "There should be a rule similar to this:"
        puts "/sbin/iptables -C INPUT -p udp --dport 69 -j ACCEPT"
      end
    else
      puts "IPtables is not dropping. Consider configuring IPtables soon."
      config
    end
  rescue Interrupt
    GExeption.new.exit_weapon("aftpd", @prev_menu)
  end

  # Exit
  def clean_exit
    exit_weapon
  end

###############################################################################
# Run methods
###############################################################################
  # Setup a TFTP server
  def config
    if Dir["/tmp/tftp"] == []
      Dir.mkdir("/tmp/tftp")
      puts "Created the /tmp/tftp directory.".light_yellow
    end
    cmd = @path + " --daemon --port 69 --logfile /var/log/atftpd.log /tmp/tftp"
    run(cmd)
    atftpd_status = `netstat -an |grep 'udp.*69'`
    if atftpd_status.empty?
      cmd = "netstat -an |grep 'udp.*69'"
      run(cmd)
      puts
      puts "Hmmmm, the server doesn't appear to have started.".red
      puts "Personally, I would try it again because I have seen it require a few attempts before.".yellow
    else
      cmd = "netstat -an |grep 'udp.*69'"
      run(cmd)
      puts "The server is running!".light_yellow
      puts "You can shutdown the server with 'killall atftpd'.".yellow
    end
    clean_exit
  end
end  
