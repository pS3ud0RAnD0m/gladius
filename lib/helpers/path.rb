# Author: p$3ud0R@nD0m

module Path
  # Source variables
  @root       = File.expand_path("../..", File.dirname(__FILE__)) + "/"
  @lib        = @root + "lib/"
  @helpers    = @lib + "helpers/"
  @input      = @helpers + "input/"
  @menus      = @lib + "menus/"
  @weapons    = @lib + "weapons/"
  @thirdparty = @helpers + "thirdparty/"
  
  # Share variables
  @share              = "/usr/share/gladius/"
  @share_input        = @share + "input/"
  @share_output       = @share + "output/"
  @share_config       = @share + "config/"
  @share_sess         = @share_config + "sessions/"
  @share_sess_named   = @share_sess + "named/"
  @share_sess_unnamed = @share_sess + "unnamed/"
  @share_tmp          = @share + "tmp/"
  @share_pids         = @share_tmp + "pids/"

  def load
    $:.push @menus
    $:.push @weapons
    $:.push @helpers
    $:.push @thirdparty
  end
  
  def req
    require "fileutils"
    require "pty"
    require "time"
    require "socket"
    require @menus + "menu"
    require @weapons + "weapon"
    Dir[@menus + "*.rb"].each { |a| require a }
    Dir[@weapons + "*.rb"].each { |a| require a }
    Dir[@helpers + "*.rb"].each { |a| require a }
    Dir[@thirdparty + "*.rb"].each { |a| require a }
  end

  def get(g_alias)
    path =
      {
        # Source directories and files
        "root"                   => @root,
        "lib"                    => @lib,
        "helpers"                => @helpers,
        "menus"                  => @menus,
        "weapons"                => @weapons,
        "thirdparty"             => @thirdparty,
        "apache_users_long"      => @input + "apache_users_long.txt",
        "dns_hosts_long"         => @input + "dns_hosts_long.txt",
        "ftp_usrs_long"          => @input + "ftp_usrs_long.txt",
        "ftp_pwds_long"          => @input + "ftp_pwds_long.txt",
        "gladius_conf"           => @input + "gladius.conf",
        "iptables"               => @input + "iptables",
        "iptables_logrotate"     => @input + "iptables_logrotate",
        "korelogic_rules"        => @input + "korelogic_rules.txt",
        "mssql_pwds_long"        => @input + "mssql_pwds_long.txt",
        "mssql_usrs_long"        => @input + "mssql_usrs_long.txt",
        "mysql_pwds_long"        => @input + "mysql_pwds_long.txt",
        "mysql_usrs_long"        => @input + "mysql_usrs_long.txt",
        "oracle_pwds_long"       => @input + "oracle_pwds_long.txt",
        "oracle_usrs_long"       => @input + "oracle_usrs_long.txt",
        "postgresql_pwds_long"   => @input + "postgresql_pwds_long.txt",
        "postgresql_usrs_long"   => @input + "postgresql_usrs_long.txt",
        "read_me"                => @root  + "README.md",
        "snmp_comm_strings_long" => @input + "snmp_comm_strings_long.txt",
        "ssh_pwds_long"          => @input + "ssh_pwds_long.txt",
        "ssh_usrs_long"          => @input + "ssh_usrs_long.txt",
        "telnet_pwds_long"       => @input + "telnet_pwds_long.txt",
        "telnet_usrs_long"       => @input + "telnet_usrs_long.txt",
        "tftp_file_list"         => @input + "tftp_file_list.txt",
        "vnc_pwds_long"          => @input + "vnc_pwds_long.txt",
        "vnc_usrs_long"          => @input + "vnc_usrs_long.txt",
        "vpn_group_id_long"      => @input + "vpn_group_id_long.txt",
        "windows_pwds_long"      => @input + "windows_pwds_long.txt",
        "windows_usrs_long"      => @input + "windows_usrs_long.txt",
        
        # Share directories and files
        "share_sess_named"   => @share_sess_named,
        "share_sess_unnamed" => @share_sess_unnamed,
        "share_sess"         => @share_sess,
        "share_config"       => @share_config,
        "share_input"        => @share_input,
        "share_output"       => @share_output,
        "share_tmp"          => @share_tmp,
        "share_pids"         => @share_pids,
        "share"              => @share,
        "share_gladius_conf" => @share_config + "gladius.conf",
        "share_seed"         => @share_input + "seed.txt",
        "share_sprout"       => @share_input + "sprout.txt",
        "share_stdin_hosts"   => @share_input + "stdin_hosts.txt",
        "share_stdin_pwds"    => @share_input + "stdin_pwds.txt",
        "share_stdin_usrs"    => @share_input + "stdin_usrs.txt",

        # System files
        "system_iptables"           => "/etc/init.d/iptables",
        "system_iptables_log"       => "/var/log/iptables.log",
        "system_iptables_logrotate" => "/etc/logrotate.d/iptables"
      }
    path[g_alias]
  end

  def get_out_file(weapon)
    Time.now.strftime(@share_output + weapon + "_%F_%H-%M-%S")
  end
  
  def get_out_file_txt(weapon)
    get_out_file(weapon) + ".txt"
  end
end
