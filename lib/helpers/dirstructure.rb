# Author: p$3ud0R@nD0m

module DirStructure
  # create structure, if it doesn"t exist
  def check
    # Source variables
    snmp_comm_strings_long = source + "snmp_comm_strings_long.txt"
    apache_users_long = source + "apache_users_long.txt"
    dns_hosts_long = source + "dns_hosts_long.txt"
    ftp_usrs_long = source + "ftp_usrs_long.txt"
    ftp_pwds_long = source + "ftp_pwds_long.txt"
    mysql_usrs_long = source + "mysql_usrs_long.txt"
    mysql_pwds_long = source + "mysql_pwds_long.txt"
    
    gladius_conf_source = Path.get_source_path("gladius_conf_source")
    gladius_iptables_logrotate_source = Path.get_source_path("gladius_iptables_logrotate_source")
    gladius_iptables_source = Path.get_source_path("gladius_iptables_source")
    ssh_usrs_long_source = Path.get_source_path("ssh_usrs_long")
    ssh_pwds_long_source = Path.get_source_path("ssh_pwds_long")
    telnet_usrs_long_source = Path.get_source_path("telnet_usrs_long")
    telnet_pwds_long_source = Path.get_source_path("telnet_pwds_long")
    vpn_group_id_long_source = Path.get_source_path("vpn_group_id_long_source")
    # Destination variables
    gladius_conf = Path.get_path("gladius_conf")
    gladius_iptables = Path.get_path("gladius_iptables")
    gladius_iptables_logrotate = Path.get_path("gladius_iptables_logrotate")
    ssh_usrs_long = Path.get_path("ssh_usrs_long")
    ssh_pwds_long = Path.get_path("ssh_pwds_long")
    telnet_usrs_long = Path.get_path("telnet_usrs_long")
    telnet_pwds_long = Path.get_path("telnet_pwds_long")
    vpn_group_id_long = Path.get_path("vpn_group_id_long")

    # Create dirs
# ttd_3: make these "each do" ..
    if Dir[usr_g] == []
      Dir.mkdir(usr_g)
    end
    if Dir[usr_i] == []
      Dir.mkdir(usr_i)
    end
    if Dir[usr_o] == []
      Dir.mkdir(usr_o)
    end
    if Dir[usr_c] == []
      Dir.mkdir(usr_c)
    end
    if Dir[usr_c_sess] == []
      Dir.mkdir(usr_c_sess)
    end
    if Dir[usr_c_sess_unnamed] == []
      Dir.mkdir(usr_c_sess_unnamed)
    end
    if Dir[usr_c_sess_named] == []
      Dir.mkdir(usr_c_sess_named)
    end
    if Dir[usr_t] == []
      Dir.mkdir(usr_t)
    end
    if Dir[usr_tp] == []
      Dir.mkdir(usr_tp)
    end
    # Create input files
    Dir.chdir(usr_i)
    if !File.exists?("stdn_hosts.txt")
      FileUtils.touch("stdn_hosts.txt")
    end
    if !File.exists?("stdn_usrs.txt")
      FileUtils.touch("stdn_usrs.txt")
    end
    if !File.exists?("stdn_pwds.txt")
      FileUtils.touch("stdn_pwds.txt")
    end
    if !File.exists?("snmp_comm_strings_long.txt")
      FileUtils.cp snmp_comm_strings_long, "snmp_comm_strings_long.txt"
    end
    if !File.exists?("apache_users_long.txt")
      FileUtils.cp apache_users_long, "apache_users_long.txt"
    end
    if !File.exists?("dns_hosts_long.txt")
      FileUtils.cp dns_hosts_long, "dns_hosts_long.txt"
    end
    if !File.exists?("ftp_usrs_long.txt")
      FileUtils.cp ftp_usrs_long, "ftp_usrs_long.txt"
    end
    if !File.exists?("ftp_pwds_long.txt")
      FileUtils.cp ftp_pwds_long, "ftp_pwds_long.txt"
    end
    if !File.exists?(gladius_iptables)
      FileUtils.cp gladius_iptables_source, gladius_iptables
    end
    if !File.exists?(gladius_iptables_logrotate)
      FileUtils.cp gladius_iptables_logrotate_source, gladius_iptables_logrotate
    end
    if !File.exists?("mysql_usrs_long.txt")
      FileUtils.cp mysql_usrs_long, "mysql_usrs_long.txt"
    end
    if !File.exists?("mysql_pwds_long.txt")
      FileUtils.cp mysql_pwds_long, "mysql_pwds_long.txt"
    end
    if !File.exists?(ssh_usrs_long)
      FileUtils.cp ssh_usrs_long_source, ssh_usrs_long
    end
    if !File.exists?(ssh_pwds_long)
      FileUtils.cp ssh_pwds_long_source, ssh_pwds_long
    end
    if !File.exists?(telnet_usrs_long)
      FileUtils.cp telnet_usrs_long_source, telnet_usrs_long
    end
    if !File.exists?(telnet_pwds_long)
      FileUtils.cp telnet_pwds_long_source, telnet_pwds_long
    end
    if !File.exists?(vpn_group_id_long)
      FileUtils.cp vpn_group_id_long_source, vpn_group_id_long
    end
    # Create config file
    splash_line = `grep previous_splash #{gladius_conf} 2> /dev/null |wc -l`.to_i
    if !File.exists?(gladius_conf) || splash_line == 0
      FileUtils.cp gladius_conf_source, gladius_conf
    end
  end
end
