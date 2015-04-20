# Author: p$3ud0R@nD0m

class SocketFuzz < Menu
  def menu
    header
    puts "Select a service to attack:".light_yellow
    puts "1. POP3 "
    puts "2. zzz (NI)".blue
    puts "88. Back"
    puts "99. Exit Gladius"

    selection = gets.to_i
    case selection
    when 1 then socketfuzzer.new("SocketFuzz", "POP3 Socket Fuzzing").menu
    #when 1 then socketfuzzer.new("SocketFuzz", "POP3 Socket Fuzzing").menu("pop3")
    when 2 then puts "Not implemented yet.".red
      menu
    when 88 then networkattacks.new("Network Attacks").menu
    when 99 then GExeption.new.exit_gladius
    else puts "Invalid selection.".red
      menu
    end
  end
end
