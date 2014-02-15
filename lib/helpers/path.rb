# Author: p$3ud0R@nD0m

module Path
  def root
    File.expand_path("../..", File.dirname(__FILE__)) + "/"
  end

  def lib_root
    File.expand_path("..", File.dirname(__FILE__)) + "/"
  end
  
  def load
    $:.push lib_root + "menus"
    $:.push lib_root + "weapons"
    $:.push lib_root + "helpers"
    $:.push lib_root + "helpers/thirdparty"
  end
  
  def req
    require lib_root + "weapons/weapon"
    Dir[lib_root + "menus/*.rb"].each { |a| require a }
    Dir[lib_root + "weapons/*.rb"].each { |a| require a }
    Dir[lib_root + "helpers/*.rb"].each { |a| require a }
    Dir[lib_root + "helpers/thirdparty/*.rb"].each { |a| require a }
    require "fileutils"
    require "pty"
    require "time"
  end

# ttd_2: Replace all path methods with this
# ttd_2: Replace all dirstruct methods with this. pay attn to trailing slashes when porting to this.
  def get_path(g_alias)
    # Usage: Path.get_path("usr")
    path =
      {
        # Directories
        "config_sess_named"   => "/usr/share/gladius/config/sessions/named/",
        "config_sess_unnamed" => "/usr/share/gladius/config/sessions/unnamed/",
        "config_sess"         => "/usr/share/gladius/config/sessions/",
        "config"              => "/usr/share/gladius/config/",
        "input"               => "/usr/share/gladius/input/",
        "output"              => "/usr/share/gladius/output/",
        "tmp_pids"            => "/usr/share/gladius/tmp/pids/",
        "tmp"                 => "/usr/share/gladius/tmp/",
        "usr_g"               => "/usr/share/gladius/",
        # Files
        "apache_users_long"          => "/usr/share/gladius/input/apache_users_long.txt",
        "dns_hosts_long"             => "/usr/share/gladius/input/dns_hosts_long.txt",
        "ftp_pwds_long"              => "/usr/share/gladius/input/ftp_pwds_long.txt",
        "ftp_pwds_short"             => "/usr/share/gladius/input/ftp_pwds_short.txt",
        "ftp_usrs_long"              => "/usr/share/gladius/input/ftp_usrs_long.txt",
        "ftp_usrs_short"             => "/usr/share/gladius/input/ftp_usrs_short.txt",
        "gladius_conf"               => "/usr/share/gladius/config/gladius.conf",
        "gladius_iptables"           => "/usr/share/gladius/input/iptables",
        "gladius_iptables_logrotate" => "/usr/share/gladius/input/iptables_logrotate",
        "mysql_pwds_long"            => "/usr/share/gladius/input/mysql_pwds_long.txt",
        "mysql_pwds_short"           => "/usr/share/gladius/input/mysql_pwds_short.txt",
        "mysql_usrs_long"            => "/usr/share/gladius/input/mysql_usrs_long.txt",
        "mysql_usrs_short"           => "/usr/share/gladius/input/mysql_usrs_short.txt",
        "postgresql_pwds_long"       => "/usr/share/gladius/input/postgresql_pwds_long.txt",
        "postgresql_pwds_short"      => "/usr/share/gladius/input/postgresql_pwds_short.txt",
        "postgresql_usrs_long"       => "/usr/share/gladius/input/postgresql_usrs_long.txt",
        "postgresql_usrs_short"      => "/usr/share/gladius/input/postgresql_usrs_short.txt",
        "snmp_comm_strings_long"     => "/usr/share/gladius/input/snmp_comm_strings_long.txt",
        "ssh_pwds_long"              => "/usr/share/gladius/input/ssh_pwds_long.txt",
        "ssh_pwds_short"             => "/usr/share/gladius/input/ssh_pwds_short.txt",
        "ssh_usrs_long"              => "/usr/share/gladius/input/ssh_usrs_long.txt",
        "ssh_usrs_short"             => "/usr/share/gladius/input/ssh_usrs_short.txt",
        "stdn_hosts"                 => "/usr/share/gladius/input/stdn_hosts.txt",
        "stdn_pwds"                  => "/usr/share/gladius/input/stdn_pwds.txt",
        "stdn_usrs"                  => "/usr/share/gladius/input/stdn_usrs.txt",
        "system_iptables"            => "/etc/init.d/iptables",
        "system_iptables_log"        => "/var/log/iptables.log",
        "system_iptables_logrotate"  => "/etc/logrotate.d/iptables",
        "telnet_pwds_long"           => "/usr/share/gladius/input/telnet_pwds_long.txt",
        "telnet_pwds_short"          => "/usr/share/gladius/input/telnet_pwds_short.txt",
        "telnet_usrs_long"           => "/usr/share/gladius/input/telnet_usrs_long.txt",
        "telnet_usrs_short"          => "/usr/share/gladius/input/telnet_usrs_short.txt",
        "tftp_file_list"             => "/usr/share/gladius/input/tftp_file_list.txt",
        "vpn_group_id_long"          => "/usr/share/gladius/input/vpn_group_id_long.txt",
        "windows_pwds_long"          => "/usr/share/gladius/input/windows_pwds_long.txt",
        "windows_pwds_short"         => "/usr/share/gladius/input/windows_pwds_short.txt",
        "windows_usrs_long"          => "/usr/share/gladius/input/windows_usrs_long.txt",
        "windows_usrs_short"         => "/usr/share/gladius/input/windows_usrs_short.txt"
      }
    path[g_alias]
  end

# ttd_2: Replace all dirstruct methods with this. pay attn to trailing slashes when porting to this.
  def get_source_path(g_alias)
    # Usage: Path.get_source_path("gladius_conf_source")
    path =
      {
        # Files
        "gladius_conf"               => lib_root + "helpers/input/gladius.conf",
        "gladius_iptables_logrotate" => lib_root + "helpers/input/iptables_logrotate",
        "gladius_iptables"           => lib_root + "helpers/input/iptables",
        "mysql_pwds_long"            => lib_root + "helpers/input/mysql_pwds_long.txt",
        "mysql_usrs_long"            => lib_root + "helpers/input/mysql_usrs_long.txt",
        "postgresql_pwds_long"       => lib_root + "helpers/input/postgresql_pwds_long.txt",
        "postgresql_usrs_long"       => lib_root + "helpers/input/postgresql_usrs_long.txt",
        "read_me"                    => root     + "README.md",
        "ssh_pwds_long"              => lib_root + "helpers/input/ssh_pwds_long.txt",
        "ssh_usrs_long"              => lib_root + "helpers/input/ssh_usrs_long.txt",
        "telnet_pwds_long"           => lib_root + "helpers/input/telnet_pwds_long.txt",
        "telnet_usrs_long"           => lib_root + "helpers/input/telnet_usrs_long.txt",
        "tftp_file_list"             => lib_root + "helpers/input/tftp_file_list.txt",
        "vpn_group_id_long"          => lib_root + "helpers/input/vpn_group_id_long.txt",
        "windows_pwds_long"          => lib_root + "helpers/input/windows_pwds_long.txt",
        "windows_usrs_long"          => lib_root + "helpers/input/windows_usrs_long.txt"
      }
    path[g_alias]
  end
  
  def stdn_pwds
    a = "/usr/share/gladius/input/stdn_pwds.txt"
  end

  def stdn_usrs
    a = "/usr/share/gladius/input/stdn_usrs.txt"
  end

  def hosts_file
    a = "/usr/share/gladius/input/stdn_hosts.txt"
  end

  def source
    a = lib_root + "helpers/input/"
  end

  def get_out_file(weapon)
    time = Time.now
    out_file = time.strftime("/usr/share/gladius/output/" + weapon + "_%F_%H-%M-%S")
  end
  
  def get_out_file_txt(weapon)
    time = Time.now
    out_file = time.strftime("/usr/share/gladius/output/" + weapon + "_%F_%H-%M-%S.txt")
  end

  def get_pid_file
    time = Time.now
    tmp_pids = Path.get_path("tmp_pids")
    pid_tstamp = "%10.10f" % time.to_f
    pid_file = time.strftime(tmp_pids + pid_tstamp + ".pid")
  end
end
