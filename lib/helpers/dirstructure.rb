# Author: p$3ud0R@nD0m

module DirStructure
  # create structure, if it doesn't exist
  def check
    # variables
    snmp_comm_strings_long = source + "snmp_comm_strings_long.txt"
    apache_usernames = source + "apache-usernames.txt"
    fierce_hosts = source + "fierce-hosts.txt"
    ftp_usrs_long = source + "ftp_usrs_long.txt"
    ftp_pwds_long = source + "ftp_pwds_long.txt"
    mysql_usrs_long = source + "mysql_usrs_long.txt"
    mysql_pwds_long = source + "mysql_pwds_long.txt"
    ssh_usrs_long = source + "ssh_usrs_long.txt"
    ssh_pwds_long = source + "ssh_pwds_long.txt"
    gladius_iptables = Path.get_source_path("gladius_iptables")

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
      FileUtils.cp snmp_comm_strings_long, 'snmp_comm_strings_long'
    end
    if !File.exists?("apache-usernames.txt")
      FileUtils.cp apache_usernames, 'apache_usernames.txt'
    end
    if !File.exists?("fierce-hosts.txt")
      FileUtils.cp fierce_hosts, 'fierce_hosts.txt'
    end
    if !File.exists?("ftp_usrs_long.txt")
      FileUtils.cp ftp_usrs_long, 'ftp_usrs_long.txt'
    end
    if !File.exists?("ftp_pwds_long.txt")
      FileUtils.cp ftp_pwds_long, 'ftp_pwds_long.txt'
    end
    if !File.exists?("gladius_iptables")
      FileUtils.cp gladius_iptables, 'gladius_iptables'
    end
    if !File.exists?("mysql_usrs_long.txt")
      FileUtils.cp mysql_usrs_long, 'mysql_usrs_long.txt'
    end
    if !File.exists?("mysql_pwds_long.txt")
      FileUtils.cp mysql_pwds_long, 'mysql_pwds_long.txt'
    end
    if !File.exists?("ssh_usrs_long.txt")
      FileUtils.cp ssh_usrs_long, 'ssh_usrs_long.txt'
    end
    if !File.exists?("ssh_pwds_long.txt")
      FileUtils.cp ssh_pwds_long, 'ssh_pwds_long.txt'  
    end
    # Create config file
    Dir.chdir(usr_c)
    if !File.exists?("gladius.conf")
      FileUtils.touch("gladius.conf")
    end
  end
end
