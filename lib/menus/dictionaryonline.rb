#!/usr/bin/env ruby

# Author:  p$3ud0R@nD0m
# Version: 0.0.2

require 'menu'

class DictionaryOnline < Menu
  def menu
    header
    puts "Select a service to attack:".light_yellow
    puts "1.  CVS (Hydra) (NI)"
    puts "2.  FTP (Hydra)"
    puts "3.  HTTP(S) (Hydra) (NI)"
    puts "4.  IMAP (Hydra) (NI)"
    puts "5.  MSSQL (Hydra) (NI)"
    puts "6.  MYSQL (Hydra)"
    puts "7.  NCP (Hydra) (NI)"
    puts "8.  NNTP (Hydra) (NI)"
    puts "9.  PCANYWHERE (Hydra) (NI)"
    puts "10. POP3 (Hydra) (NI)"
    puts "11. POSTGRES (Hydra) (NI)"
    puts "12. RDP (Ncrack) (NI)"
    puts "13. REXEC (Hydra) (NI)"
    puts "14. RLOGIN (Hydra) (NI)"
    puts "15. RSH (Hydra) (NI)"
    puts "16. SMB (Ncrack) (NI)"
    puts "17. SMTP-VRFY (Hydra) (NI)"
    puts "18. SMTP (Hydra) (NI)"
    puts "19. SNMP (onesixtyone) (NI)"
    puts "20. SSH (Hydra)"
    puts "21. SVN (Hydra) (NI)"
    puts "22. TELNET (Hydra) (NI)"
    puts "23. VMAUTHD (Hydra) (NI)"
    puts "24. VNC (Hydra) (NI)"
    puts "25. WEB-FORM (Hydra) (NI)"
    puts "88. Back"
    puts "99. Exit Gladius"

    sel = gets.to_i
    puts
    if sel == 1
      puts "Not implemented yet.".red
      menu
    elsif sel == 2
      Hydra.new("Hydra - FTP Online Dictionary Attack").ftp
    elsif sel == 3
      puts "Not implemented yet.".red
      menu
    elsif sel == 4
      puts "Not implemented yet.".red
      menu
    elsif sel == 5
      puts "Not implemented yet.".red
      menu
    elsif sel == 6
      Hydra.new("Hydra - MySQL Online Dictionary Attack").mysql
    elsif sel == 7
      puts "Not implemented yet.".red
      menu
    elsif sel == 8
      puts "Not implemented yet.".red
      menu
    elsif sel == 9
      puts "Not implemented yet.".red
      menu
    elsif sel == 10
      puts "Not implemented yet.".red
      menu
    elsif sel == 11
      puts "Not implemented yet.".red
      menu
    elsif sel == 12
      puts "Not implemented yet.".red
      menu
    elsif sel == 13
      puts "Not implemented yet.".red
      menu
    elsif sel == 14
      puts "Not implemented yet.".red
      menu
    elsif sel == 15
      puts "Not implemented yet.".red
      menu
    elsif sel == 16
      puts "Not implemented yet.".red
      menu
    elsif sel == 17
      puts "Not implemented yet.".red
      menu
    elsif sel == 18
      puts "Not implemented yet.".red
      menu
    elsif sel == 19
      puts "Not implemented yet.".red
      menu
    elsif sel == 20
      Hydra.new("Hydra - SSH Online Dictionary Attack").ssh
    elsif sel == 21
      puts "Not implemented yet.".red
      menu
    elsif sel == 22
      puts "Not implemented yet.".red
      menu
    elsif sel == 23
      puts "Not implemented yet.".red
      menu
    elsif sel == 24
      puts "Not implemented yet.".red
      menu
    elsif sel == 25
      puts "Not implemented yet.".red
      menu
    elsif sel == 9
      puts "Not implemented yet.".red
      menu
    elsif sel == 88
      Dictionary.new("Dictionary Attacks").menu
    elsif sel == 99
      begin
      puts "Exiting Gladius. Have a bloody day!".red
      puts
      rescue Interrupt
      end
    else
      puts "Invalid selection.".red
      menu
    end
  end
end

