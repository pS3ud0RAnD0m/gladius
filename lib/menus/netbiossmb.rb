# Author: p$3ud0R@nD0m

class NetbiosSMB < Menu
  def menu
    header
    puts "Select a tactic:".light_yellow
    puts "1.  Enumerate SMB/Samba information (Enum4linux)"
    puts "88. Back"
    puts "99. Exit Gladius"
    
    selection = gets.to_i
    case selection
    when 1 then Enum4linux.new("NetbiosSMB", "Enum4linux - Enum SMB/Samba Info").menu("all")
    when 88 then GatherInfo.new("Information Gathering").menu
    when 99 then GExeption.new.exit_gladius
    else puts "Invalid selection.".red
      menu
    end
  end
end
