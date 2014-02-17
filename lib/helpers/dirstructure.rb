# Author: p$3ud0R@nD0m

module DirStructure
  # Create structure, if it doesn't exist
  def check
    gladius_conf = Path.get("gladius_conf")
    share_gladius_conf = Path.get("share_gladius_conf")

    # Directories to be created
    dirs = [ "share",
             "share_config",
             "share_sess",
             "share_sess_named",
             "share_sess_unnamed",
             "share_input",
             "share_output",
             "share_tmp",
             "share_pids"
            ]
    
    # Files to be created
    files = [ "share_stdn_hosts",
              "share_stdn_pwds",
              "share_stdn_usrs"
            ]

    # Create directories
    dirs.each do |create|
      dir = Path.get(create)
      if Dir[dir] == []
        Dir.mkdir(dir)
      end
    end

    # Create files
    files.each do |create|
      file = Path.get(create)
      if !File.exists?(file)
        FileUtils.touch(file)
      end
    end

    # Copy config file
    if !File.exists?(share_gladius_conf)
      FileUtils.cp gladius_conf, share_gladius_conf
    end
  end
end
