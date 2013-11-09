# Author: p$3ud0R@nD0m

require 'menu'

class DictionaryOnline < Menu
  def menu
    header
    puts "Select a service to attack:".light_yellow
    puts "1.  CVS (Hydra) (NI)"
    puts "2.  DNS (Fierce)"
    puts "3.  FTP (Hydra)"
    puts "4.  HTTP(S) (Hydra) (NI)"
    puts "5.  IMAP (Hydra) (NI)"
    puts "6.  MSSQL (Hydra) (NI)"
    puts "7.  MySQL (Hydra)"
    puts "8.  NCP (Hydra) (NI)"
    puts "9.  NNTP (Hydra) (NI)"
    puts "10. PCAnywhere (Hydra) (NI)"
    puts "11. POP3 (Hydra) (NI)"
    puts "12. PostgreSQL (Hydra) (NI)"
    puts "13. RDP (Ncrack) (NI)"
    puts "14. Rexec (Hydra) (NI)"
    puts "15. Rlogin (Hydra) (NI)"
    puts "16. RSH (Hydra) (NI)"
    puts "17. SMB (Ncrack) (NI)"
    puts "18. SMTP (Hydra) (NI)"
    puts "19. SMTP-Enum (Hydra) (NI)"
    puts "20. SNMP (Nmap)"
    puts "21. SSH (Hydra)"
    puts "22. SVN (Hydra) (NI)"
    puts "23. Telnet (Hydra)"
    puts "24. VMAuthd (Hydra) (NI)"
    puts "25. VNC (Hydra) (NI)"
    puts "26. Web-Form (Hydra) (NI)"
    puts "88. Back"
    puts "99. Exit Gladius"

    selection = gets.to_i
    puts
    case selection
    when 1 then puts "Not implemented yet.".red
      menu
    when 2 then Fierce.new("DNS", "Fierce - DNS Transfer or Online Dictionary Attack").menu("dictionary")
    when 3 then Hydra.new("DictionaryOnline", "Hydra - FTP Online Dictionary Attack").menu("ftp")
    when 4 then puts "Not implemented yet.".red
      menu
    when 5 then puts "Not implemented yet.".red
      menu
    when 6 then puts "Not implemented yet.".red
      menu
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
    when 13 then puts "Not implemented yet.".red
      menu
    when 14 then puts "Not implemented yet.".red
      menu
    when 15 then puts "Not implemented yet.".red
      menu
    when 16 then puts "Not implemented yet.".red
      menu
    when 17 then puts "Not implemented yet.".red
      menu
    when 18 then puts "Not implemented yet.".red
      menu
    when 19 then puts "Not implemented yet.".red
      menu
    when 20 then GNmap.new("SNMP", "Nmap - SNMP Online Dictionary Attack").menu("script_snmp_dictionary")
    when 21 then Hydra.new("DictionaryOnline", "Hydra - SSH Online Dictionary Attack").menu("ssh")
    when 22 then puts "Not implemented yet.".red
      menu
    when 23 then Hydra.new("DictionaryOnline", "Hydra - Telnet Online Dictionary Attack").menu("telnet")
    when 24 then puts "Not implemented yet.".red
      menu
    when 25 then puts "Not implemented yet.".red
      menu
    when 26 then puts "Not implemented yet.".red
      menu
    when 88 then Dictionary.new("Dictionary Attacks").menu
    when 99 then GExeption.new.exit_gladius
    else puts "Invalid selection.".red
    menu
    end
  end
end

