# Author: p$3ud0R@nD0m

require 'menu'
# ttd_1: Complete all online dict attacks
class DictionaryOnline < Menu
  def menu
    header
    puts "Select a service to attack:".light_yellow
    puts "1.  CVS (Hydra) (NI)".blue
    puts "2.  DNS (Fierce)"
    puts "3.  FTP (Hydra)"
    puts "4.  HTTP(S) (Hydra) (NI)".blue
    puts "5.  IMAP (Hydra) (NI)".blue
    puts "6.  MSSQL (Hydra)"
    puts "7.  MySQL (Hydra)"
    puts "8.  NCP (Hydra) (NI)".blue
    puts "9.  NNTP (Hydra) (NI)" .blue  
    puts "10. Oracle (Hydra) (NI)".blue
    puts "11. PCAnywhere (Hydra) (NI)".blue
    puts "12. POP3 (Hydra) (NI)".blue
    puts "13. PostgreSQL (Hydra)"
    puts "14. RDP (Ncrack)"
    puts "15. Rexec (Hydra)"
    puts "16. Rlogin (Hydra)"
    puts "17. RSH (Hydra)"
    puts "18. SMB (Medusa)"
    puts "19. SMTP (Hydra) (NI)".blue
    puts "20. SMTP-Enum (Hydra) (NI)".blue
    puts "21. SNMP (Nmap)"
    puts "22. SSH (Hydra)"
    puts "23. SVN (Hydra) (NI)".blue
    puts "24. Telnet (Hydra)"
    puts "25. VMAuthd (Hydra)"
    puts "26. VNC (Hydra)"
    puts "27. Web-Form (Hydra) (NI)".blue
    puts "88. Back"
    puts "99. Exit Gladius"

    selection = gets.to_i
    case selection
    when 1 then puts "Not implemented yet.".red
      menu
    when 2 then Fierce.new("DictionaryOnline", "Fierce - DNS Transfer or Online Dictionary Attack").menu("dictionary")
    when 3 then Hydra.new("DictionaryOnline", "Hydra - FTP Online Dictionary Attack").menu("ftp")
    when 4 then puts "Not implemented yet.".red
      menu
    when 5 then puts "Not implemented yet.".red
      menu
    when 6 then Hydra.new("DictionaryOnline", "Hydra - MSSQL Online Dictionary Attack").menu("mssql")
    when 7 then Hydra.new("DictionaryOnline", "Hydra - MySQL Online Dictionary Attack").menu("mysql")
    when 8 then puts "Not implemented yet.".red
      menu
    when 9 then puts "Not implemented yet.".red
      menu
    when 10 then puts "Not implemented yet.".red
      menu
    when 11 then puts "Not implemented yet.".red
      menu
    when 12 then puts "Not implemented yet.".red
      menu
    when 13 then Hydra.new("DictionaryOnline", "Hydra - PostgreSQL Online Dictionary Attack").menu("postgresql")
    when 14 then Ncrack.new("DictionaryOnline", "Ncrack - RDP Online Dictionary Attack").menu("rdp")
    when 15 then Hydra.new("DictionaryOnline", "Hydra - Rexec Online Dictionary Attack").menu("rexec")
    when 16 then Hydra.new("DictionaryOnline", "Hydra - Rlogin Online Dictionary Attack").menu("rlogin")
    when 17 then Hydra.new("DictionaryOnline", "Hydra - RSH Online Dictionary Attack").menu("rsh")
    when 18 then Medusa.new("DictionaryOnline", "Medusa - SMB Online Dictionary Attack").menu("smb")
    when 19 then puts "Not implemented yet.".red
      menu
    when 20 then puts "Not implemented yet.".red
      menu
    when 21 then GNmap.new("DictionaryOnline", "Nmap - SNMP Online Dictionary Attack").menu("script_snmp_dictionary")
    when 22 then Hydra.new("DictionaryOnline", "Hydra - SSH Online Dictionary Attack").menu("ssh")
    when 23 then puts "Not implemented yet.".red
      menu
    when 24 then Hydra.new("DictionaryOnline", "Hydra - Telnet Online Dictionary Attack").menu("telnet")
    when 25 then Hydra.new("DictionaryOnline", "Hydra - VMAuthd Online Dictionary Attack").menu("vmauthd")
    when 26 then Hydra.new("DictionaryOnline", "Hydra - VNC Online Dictionary Attack").menu("vnc")
    when 27 then puts "Not implemented yet.".red
      menu
    when 88 then Dictionary.new("Dictionary Attacks").menu
    when 99 then GExeption.new.exit_gladius
    else puts "Invalid selection.".red
    menu
    end
  end
end

