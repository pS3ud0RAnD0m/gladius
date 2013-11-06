# Author: p$3ud0R@nD0m

class Splash
  def initialize
    @gladius_conf = Path.get_path("gladius_conf")
  end

# ttd_4: Refactor splash iteration.
  def iterate
    if File.exist?(@gladius_conf)
      splash_line = open(@gladius_conf) { |a| a.grep(/previous_splash/) }
      splash_line_array = splash_line.to_s.split
      old_splash_value = splash_line_array[2].to_i
      case old_splash_value
        when 1 then new_splash_value = 2
        when 2 then new_splash_value = 3
        when 3 then new_splash_value = 4
        when 4 then new_splash_value = 5
        when 5 then new_splash_value = 6
        when 6 then new_splash_value = 7
        when 7 then new_splash_value = 8
        when 8 then new_splash_value = 9
        when 9 then new_splash_value = 1
        else new_splash_value = 8
      end
      old_splash_value_string = old_splash_value.to_s
      new_splash_value_string = new_splash_value.to_s
      display(new_splash_value)
      a = File.read(@gladius_conf)
      replace = a.gsub(/#{old_splash_value_string}/, new_splash_value_string)
      File.open(@gladius_conf, "w") {|file| file.puts replace}
    end
  end

  def display(splash_value)
    case splash_value
      when 1 then splash_1
      when 2 then splash_2
      when 3 then splash_3
      when 4 then splash_4
      when 5 then splash_5
      when 6 then splash_6
      when 7 then splash_7
      when 8 then splash_8
      when 9 then splash_9
      else splash_9
    end
  end

  def splash_1
    puts
    puts "                                  /\\"
    puts "                                 /  \\"
    puts "                                 |  |"
    puts "                                 |  |"
    puts "                                 |" + "  |"
    puts "                                 |  |"
    puts "                                 |  |"
    puts "    ________                  ___|  |"
    puts "   /  _____/ __  _____     __| _/|  |__ __   ________"
    puts "  /   \\  ___|  | \\__  \\   / __ | |  |  |  \\ /  _____/"
    puts "  \\    \\_\\  \\  |__/ __ \\_/ /_/ | |  |  |   /\\____  \\"
    puts "   \\______  /____/_____  /\\___ | |  |_____/________/"
    puts "          \\/           \\/     \\/ |__|"
    puts "                                [_  _]"
    puts "                                  ()"
    puts "    Viam inveniam aut faciam!     ()"
    puts "                                  ()"
    puts "                                 (  )    Find a way or make one!"
    puts "                                  \\/"
    puts
  end

  def splash_2
    puts
    puts "                                  /\\".red
    puts "                                 /  \\".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "                                 |" + "  |".red
    puts "                                 |  |"
    puts "                                 |  |"
    puts "    ________                  ___|  |"
    puts "   /  _____/ __  _____     __| _/|  |__ __   ________"
    puts "  /   \\  ___|  | \\__  \\   / __ | |  |  |  \\ /  _____/"
    puts "  \\    \\_\\  \\  |__/ __ \\_/ /_/ | |  |  |   /\\____  \\"
    puts "   \\______  /____/_____  /\\___ | |  |_____/________/"
    puts "          \\/           \\/     \\/ |__|"
    puts "                                [_  _]"
    puts "                                  ()"
    puts "    Viam inveniam aut faciam!     ()"
    puts "                                  ()"
    puts "                                 (  )    Find a way or make one!"
    puts "                                  \\/"
    puts
  end

  def splash_3
    puts
    puts "                                  /\\".red
    puts "                                 /  \\".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "    ________                  ___" + "|  |".red
    puts "   /  _____/ __  _____     __| _/" + "|  |".red + "__ __   ________"
    puts "  /   \\  ___|  | \\__  \\   / __ | " + "|  |".red + "  |  \\ /  _____/"
    puts "  \\    \\_\\  \\  |__/ __ \\_/ /_/ | |  " + "|".red + "  |   /\\____  \\"
    puts "   \\______  /____/_____  /\\___ | |  |_____/________/"
    puts "          \\/           \\/     \\/ |__|"
    puts "                                [_  _]"
    puts "                                  ()"
    puts "    Viam inveniam aut faciam!     ()"
    puts "                                  ()"
    puts "                                 (  )    Find a way or make one!"
    puts "                                  \\/"
    puts
  end

  def splash_4
    puts
    puts "                                  /\\".red
    puts "                                 /  \\".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "    ________                  ___" + "|  |".red
    puts "   /  _____/ __  _____     __| _/" + "|  |".red + "__ __   ________"
    puts "  /   \\  ___|  | \\__  \\   / __ | " + "|  |".red + "  |  \\ /  _____/"
    puts "  \\    \\_\\  \\  |__/ __ \\_/ /_/ | " + "|  |".red + "  |   /\\____  \\"
    puts "   \\______  /____/_____  /\\___ | " + "|  |".red + "_____/________/"
    puts "          \\/           \\/     \\/ " + "|__|".red
    puts "                                [_  _]".red
    puts "                                  ()".red
    puts "    Viam inveniam aut faciam!     " + "()".red
    puts "                                  ()".red
    puts "                                 (  )    ".red + "Find a way or make one!"
    puts "                                  \\/".red
    puts
  end

  def splash_5
    puts
    puts "                                  /\\".red
    puts "                                 /  \\".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "    ________                  ___" + "|  |".red
    puts "   /  _____/ __  _____     __| _/" + "|  |".red + "__ __   ________"
    puts "  /   \\  ___|  | \\__  \\   / __ | " + "|  |".red + "  |  \\ /  _____/"
    puts "  \\    \\_\\  \\  |__/ __ \\_/ /_/ | " + "|  |".red + "  |   /\\____  \\"
    puts "   \\______  /____/_____  /\\___ | " + "|  |".red + "_____/________/"
    puts "          \\/           \\/     \\/ " + "|__|".red
    puts "                                [_  _]".red
    puts "                                  ()".red
    puts "    Viam inveniam aut faciam!     " + "()".red
    puts "                                  ()".red
    puts "                                 (  )    Find a way or make one!".red
    puts "                                  \\/".red
    puts
  end

  def splash_6
    puts
    puts "                                  /\\".red
    puts "                                 /  \\".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "    ________                  ___" + "|  |".red
    puts "   /  _____/ __  _____     __| _/" + "|  |".red + "__ __   ________"
    puts "  /   \\  ___|  | \\__  \\   / __ | " + "|  |".red + "  |  \\ /  _____/"
    puts "  \\    \\_\\  \\  |__/ __ \\_/ /_/ | " + "|  |".red + "  |   /\\____  \\"
    puts "   \\______  /____/_____  /\\___ | " + "|  |".red + "_____/________/"
    puts "          \\/           \\/     \\/ " + "|__|".red
    puts "                                [_  _]".red
    puts "                                  ()".red
    puts "    Viam inveniam aut faciam!     ()".red
    puts "                                  ()".red
    puts "                                 (  )    Find a way or make one!".red
    puts "                                  \\/".red
    puts
  end

  def splash_7
    puts
    puts "                                  /\\".red
    puts "                                 /  \\".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "    ________                  ___" + "|  |".red
    puts "   /  _____/ __  _____     __| _/" + "|  |".red + "__ __   ________"
    puts "  /   \\  ___|  | \\__  \\   / __ | " + "|  |".red + "  |  \\ /  _____/"
    puts "  \\    \\_\\  \\  |__/ __ \\_/ /_/ | " + "|  |".red + "  |   /\\____  \\"
    puts "   \\______  /____/_____  /\\___ | " + "|  |".red + "_____/________/"
    puts "          \\/           \\/     \\/ |__|".red
    puts "                                [_  _]".red
    puts "                                  ()".red
    puts "    Viam inveniam aut faciam!     ()".red
    puts "                                  ()".red
    puts "                                 (  )    Find a way or make one!".red
    puts "                                  \\/".red
    puts
  end

  def splash_8
    puts
    puts "                                  /\\".red
    puts "                                 /  \\".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "    ________                  ___" + "|  |".red
    puts "   /  _____/ __  _____     __| _/" + "|  |".red + "__ __   ________"
    puts "  /   \\  ___|  | \\__  \\   / __ | " + "|  |".red + "  |  \\ /  _____/"
    puts "  \\    \\_\\  \\  |__/ __ \\_/ /_/ | " + "|  |".red + "  |   /\\____  \\"
    puts "   \\______  /____/_____  /\\___ | |  |_____/________/".red
    puts "          \\/           \\/     \\/ |__|".red
    puts "                                [_  _]".red
    puts "                                  ()".red
    puts "    Viam inveniam aut faciam!     ()".red
    puts "                                  ()".red
    puts "                                 (  )    Find a way or make one!".red
    puts "                                  \\/".red
    puts
  end

  def splash_9
    puts
    puts "                                  /\\".red
    puts "                                 /  \\".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "                                 |  |".red
    puts "    ________                  ___" + "|  |".red
    puts "   /  _____/ __  _____     __| _/" + "|  |".red + "__ __   ________"
    puts "  /   \\  ___|  | \\__  \\   / __ | " + "|  |".red + "  |  \\ /  _____/"
    puts "  \\    \\_\\  \\  |__/ __ \\_/ /_/ | |  |  |   /\\____  \\".red
    puts "   \\______  /____/_____  /\\___ | |  |_____/________/".red
    puts "          \\/           \\/     \\/ |__|".red
    puts "                                [_  _]".red
    puts "                                  ()".red
    puts "    Viam inveniam aut faciam!     ()".red
    puts "                                  ()".red
    puts "                                 (  )    Find a way or make one!".red
    puts "                                  \\/".red
    puts
  end
end
