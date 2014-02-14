# Author: p$3ud0R@nD0m

module DirStructure
  # create structure, if it doesn"t exist
  def check
    # Source variables
    snmp_comm_strings_long = source + "snmp_comm_strings_long.txt"
    apache_users_long = source + "apache_users_long.txt"
    dns_hosts_long = source + "dns_hosts_long.txt"
    ftp_usrs_long_source = Path.get_source_path("ftp_usrs_long")
    ftp_pwds_long_source = Path.get_source_path("ftp_pwds_long")
    gladius_conf_source = Path.get_source_path("gladius_conf")
    gladius_iptables_logrotate_source = Path.get_source_path("gladius_iptables_logrotate")
    gladius_iptables_source = Path.get_source_path("gladius_iptables")
    mysql_pwds_long_source = Path.get_source_path("mysql_pwds_long")
    mysql_usrs_long_source = Path.get_source_path("mysql_usrs_long")
    postgresql_pwds_long_source = Path.get_source_path("postgresql_pwds_long")
    postgresql_usrs_long_source = Path.get_source_path("postgresql_usrs_long")
    ssh_pwds_long_source = Path.get_source_path("ssh_pwds_long")
    ssh_usrs_long_source = Path.get_source_path("ssh_usrs_long")
    telnet_pwds_long_source = Path.get_source_path("telnet_pwds_long")
    telnet_usrs_long_source = Path.get_source_path("telnet_usrs_long")
    tftp_file_list_source = Path.get_source_path("tftp_file_list")
    vpn_group_id_long_source = Path.get_source_path("vpn_group_id_long")
    windows_pwds_long_source = Path.get_source_path("windows_pwds_long")
    windows_usrs_long_source = Path.get_source_path("windows_usrs_long")
    
    # Destination variables
    config = Path.get_path("config")
    config_sess = Path.get_path("config_sess")
    config_sess_named = Path.get_path("config_sess_named")
    config_sess_unnamed = Path.get_path("config_sess_unnamed")
    input = Path.get_path("input")
    output = Path.get_path("output")
    tmp = Path.get_path("tmp")
    tmp_pids = Path.get_path("tmp_pids")
    usr = Path.get_path("usr")
    usr_g = Path.get_path("usr_g")
    ftp_usrs_long = Path.get_path("ftp_usrs_long")
    ftp_pwds_long = Path.get_path("ftp_pwds_long")
    gladius_conf = Path.get_path("gladius_conf")
    gladius_iptables = Path.get_path("gladius_iptables")
    gladius_iptables_logrotate = Path.get_path("gladius_iptables_logrotate")
    mysql_pwds_long = Path.get_path("mysql_pwds_long")
    mysql_usrs_long = Path.get_path("mysql_usrs_long")
    postgresql_pwds_long = Path.get_path("postgresql_pwds_long")
    postgresql_usrs_long = Path.get_path("postgresql_usrs_long")
    ssh_pwds_long = Path.get_path("ssh_pwds_long")
    ssh_usrs_long = Path.get_path("ssh_usrs_long")
    telnet_pwds_long = Path.get_path("telnet_pwds_long")
    telnet_usrs_long = Path.get_path("telnet_usrs_long")
    tftp_file_list = Path.get_path("tftp_file_list")
    vpn_group_id_long = Path.get_path("vpn_group_id_long")
    windows_pwds_long = Path.get_path("windows_pwds_long")
    windows_usrs_long = Path.get_path("windows_usrs_long")

    # Create dirs
# ttd_3: make these "each do" ..
    if Dir[usr_g] == []
      Dir.mkdir(usr_g)
    end
    if Dir[input] == []
      Dir.mkdir(input)
    end
    if Dir[output] == []
      Dir.mkdir(output)
    end
    if Dir[output] == []
      Dir.mkdir(config)
    end
    if Dir[config_sess] == []
      Dir.mkdir(config_sess)
    end
    if Dir[config_sess_unnamed] == []
      Dir.mkdir(config_sess_unnamed)
    end
    if Dir[config_sess_named] == []
      Dir.mkdir(config_sess_named)
    end
    if Dir[tmp] == []
      Dir.mkdir(tmp)
    end
    if Dir[tmp_pids] == []
      Dir.mkdir(tmp_pids)
    end
    # Create input files
    Dir.chdir(input)
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
    if !File.exists?(ftp_usrs_long)
      FileUtils.cp ftp_usrs_long_source, ftp_usrs_long
    end
    if !File.exists?(ftp_pwds_long)
      FileUtils.cp ftp_pwds_long_source, ftp_pwds_long
    end
    if !File.exists?(gladius_iptables)
      FileUtils.cp gladius_iptables_source, gladius_iptables
    end
    if !File.exists?(gladius_iptables_logrotate)
      FileUtils.cp gladius_iptables_logrotate_source, gladius_iptables_logrotate
    end
    if !File.exists?(mysql_usrs_long)
      FileUtils.cp mysql_usrs_long_source, mysql_usrs_long
    end
    if !File.exists?(mysql_pwds_long)
      FileUtils.cp mysql_pwds_long_source, mysql_pwds_long
    end
    if !File.exists?(postgresql_usrs_long)
      FileUtils.cp postgresql_usrs_long_source, postgresql_usrs_long
    end
    if !File.exists?(postgresql_pwds_long)
      FileUtils.cp postgresql_pwds_long_source, postgresql_pwds_long
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
    if !File.exists?(tftp_file_list)
      FileUtils.cp tftp_file_list_source, tftp_file_list
    end
    if !File.exists?(vpn_group_id_long)
      FileUtils.cp vpn_group_id_long_source, vpn_group_id_long
    end
    if !File.exists?(windows_usrs_long)
      FileUtils.cp windows_usrs_long_source, windows_usrs_long
    end
    if !File.exists?(windows_pwds_long)
      FileUtils.cp windows_pwds_long_source, windows_pwds_long
    end
    # Create config file
    splash_line = `grep previous_splash #{gladius_conf} 2> /dev/null |wc -l`.to_i
    if !File.exists?(gladius_conf) || splash_line == 0
      FileUtils.cp gladius_conf_source, gladius_conf
    end
  end
end
