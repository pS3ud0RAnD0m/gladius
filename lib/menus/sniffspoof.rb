# Author: p$3ud0R@nD0m

class SniffSpoof < Menu
  def menu
    header
    puts "Select a task:".light_yellow
    puts "1.  Sniff for plaintext creds (Dsniff)"
    puts "2.  MiTM ARP poisoning (Ettercap) (NI)".blue
    puts "88. Back"
    puts "99. Exit Gladius"
    
    selection = gets.to_i
    case selection
    when 1 then Dsniff.new("SniffSpoof", "Dsniff - Sniff for plaintext creds").menu("all")
    when 2 then puts "Not implemented yet.".red
      menu
    when 88 then NetworkAttacks.new("Network Attacks").menu
    when 99 then GExeption.new.exit_gladius
    else puts "Invalid selection.".red
      menu
    end
  end
end