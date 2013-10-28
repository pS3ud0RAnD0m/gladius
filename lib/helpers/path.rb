# Author: p$3ud0R@nD0m

module Path
  def lib_root
    root = File.expand_path("..", File.dirname(__FILE__))
  end

  def load
    $:.push lib_root + "/menus"
    $:.push lib_root + "/weapons"
    $:.push lib_root + "/helpers"
    $:.push lib_root + "/helpers/thirdparty"
  end
  
  def req
    Dir[lib_root + "/menus/*.rb"].each { |a| require a }
    Dir[lib_root + "/weapons/*.rb"].each { |a| require a }
    Dir[lib_root + "/helpers/*.rb"].each { |a| require a }
    Dir[lib_root + "/helpers/thirdparty/*.rb"].each { |a| require a }
    require 'fileutils'
    require 'pty'
    require 'time'
  end

# ttd_2: Replace all path methods with this
# ttd_2: Replace all dirstruct methods with this. pay attn to trailing slashes when porting to this.
  def get_path(g_alias)
    # Path.get_path("usr")
    path =
      {
        # Directories
        'config_sess_named'   => '/usr/share/gladius/config/sessions/named/',
        'config_sess_unnamed' => '/usr/share/gladius/config/sessions/unnamed/',
        'config_sess'         => '/usr/share/gladius/config/sessions/',
        'config'              => '/usr/share/gladius/config/',
        'input'               => '/usr/share/gladius/input/',
        'output'              => '/usr/share/gladius/output/',
        'tmp_pids'            => '/usr/share/gladius/tmp/pids/',
        'tmp'                 => '/usr/share/gladius/tmp/',
        'usr_g'               => '/usr/share/gladius/',
        'usr'                 => '/usr/share/',
        # Files
        'ftp_pwds_long'          => '/usr/share/gladius/input/ftp_pwds_long.txt',
        'ftp_pwds_short'         => '/usr/share/gladius/input/ftp_pwds_short.txt',
        'ftp_usrs_long'          => '/usr/share/gladius/input/ftp_usrs_long.txt',
        'ftp_usrs_short'         => '/usr/share/gladius/input/ftp_usrs_short.txt',
        'gladius_iptables'       => '/usr/share/gladius/input/iptables',
        'mysql_pwds_long'        => '/usr/share/gladius/input/mysql_pwds_long.txt',
        'mysql_pwds_short'       => '/usr/share/gladius/input/mysql_pwds_short.txt',
        'mysql_usrs_long'        => '/usr/share/gladius/input/mysql_usrs_long.txt',
        'mysql_usrs_short'       => '/usr/share/gladius/input/mysql_usrs_short.txt',
        'snmp_comm_strings_long' => '/usr/share/gladius/input/snmp_comm_strings_long.txt',
        'ssh_pwds_long'          => '/usr/share/gladius/input/ssh_pwds_long.txt',
        'ssh_pwds_short'         => '/usr/share/gladius/input/ssh_pwds_short.txt',
        'ssh_usrs_long'          => '/usr/share/gladius/input/hydra_ssh_usrs_long.txt',
        'ssh_usrs_short'         => '/usr/share/gladius/input/hydra_ssh_usrs_short.txt',
        'stdn_hosts'             => '/usr/share/gladius/input/stdn_hosts.txt',
        'stdn_pwds'              => '/usr/share/gladius/input/stdn_pwds.txt',
        'stdn_usrs'              => '/usr/share/gladius/input/stdn_usrs.txt'
      }
    path[g_alias]
  end

# ttd_2: Replace all dirstruct methods with this. pay attn to trailing slashes when porting to this.
  def get_source_path(g_alias)
    # Path.get_path("usr")
    path =
      {
        # Files
        "gladius_iptables" => lib_root + "/helpers/input/gladius_iptables"
      }
    path[g_alias]
  end
  
  def snmp_comm_strings_long
    a = "/usr/share/gladius/input/snmp_comm_strings_long.txt"
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

  def usr
    a = "/usr/share"
  end
  
  def usr_g
    usr = "/usr/share/gladius"
  end
  
  def usr_i
    a = "/usr/share/gladius/input"
  end
  
  def usr_o
    a = "/usr/share/gladius/output"
  end
  
  def usr_c
    a = "/usr/share/gladius/config"
  end

  def usr_c_sess
    a = "/usr/share/gladius/config/sessions"
  end

  def usr_c_sess_unnamed
    a = "/usr/share/gladius/config/sessions/unnamed"
  end
  
  def usr_c_sess_named
    a = "/usr/share/gladius/config/sessions/named"
  end

  def usr_t
    a = "/usr/share/gladius/tmp"
  end
  
  def usr_tp
    a = "/usr/share/gladius/tmp/pids/"
  end
  
  def source
    a = lib_root + "/helpers/input/"
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
    pid_tstamp = "%10.10f" % time.to_f
    pid_file = time.strftime(usr_tp + pid_tstamp + ".pid")
  end
end
