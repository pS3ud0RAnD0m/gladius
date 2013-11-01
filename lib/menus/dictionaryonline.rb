#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require 'menu'

class DictionaryOnline < Menu
  def menu
    header
    puts "Select a service to attack:".light_yellow
    puts "1.  CVS (Hydra) (NI)"
# ttd_1: add dns (fierce)
    puts "2.  FTP (Hydra)"
    puts "3.  HTTP(S) (Hydra) (NI)"
    puts "4.  IMAP (Hydra) (NI)"
    puts "5.  MSSQL (Hydra) (NI)"
    puts "6.  MySQL (Hydra)"
    puts "7.  NCP (Hydra) (NI)"
    puts "8.  NNTP (Hydra) (NI)"
    puts "9.  PCAnywhere (Hydra) (NI)"
    puts "10. POP3 (Hydra) (NI)"
    puts "11. PostgreSQL (Hydra) (NI)"
    puts "12. RDP (Ncrack) (NI)"
    puts "13. Rexec (Hydra) (NI)"
    puts "14. Rlogin (Hydra) (NI)"
    puts "15. RSH (Hydra) (NI)"
    puts "16. SMB (Ncrack) (NI)"
    puts "17. SMTP (Hydra) (NI)"
    puts "18. SMTP-Enum (Hydra) (NI)"
    puts "19. SNMP (onesixtyone) (NI)"
    puts "20. SSH (Hydra)"
    puts "21. SVN (Hydra) (NI)"
    puts "22. Telnet (Hydra) (NI)"
    puts "23. VMAuthd (Hydra) (NI)"
    puts "24. VNC (Hydra) (NI)"
    puts "25. Web-Form (Hydra) (NI)"
    puts "88. Back"
    puts "99. Exit Gladius"

    selection = gets.to_i
    puts
    case selection
      when 1 then puts "Not implemented yet.".red
        menu
      when 2 then Hydra.new("DictionaryOnline", "Hydra - FTP Online Dictionary Attack").menu("ftp")
      when 3 then puts "Not implemented yet.".red
        menu
      when 4 then puts "Not implemented yet.".red
        menu
      when 5 then puts "Not implemented yet.".red
        menu
      when 6 then Hydra.new("DictionaryOnline", "Hydra - MySQL Online Dictionary Attack").menu("mysql")
      when 7 then puts "Not implemented yet.".red
        menu
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
      when 20 then Hydra.new("DictionaryOnline", "Hydra - SSH Online Dictionary Attack").menu("ssh")
      when 21 then puts "Not implemented yet.".red
        menu
      when 22 then puts "Not implemented yet.".red
        menu
      when 23 then puts "Not implemented yet.".red
        menu
      when 24 then puts "Not implemented yet.".red
        menu
      when 25 then puts "Not implemented yet.".red
        menu
      when 88 then Dictionary.new("Dictionary Attacks").menu
      when 99 then GExeption.new.exit_gladius
      else puts "Invalid selection.".red
      menu
    end
  end
end

