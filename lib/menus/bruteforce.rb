#!/usr/bin/env ruby

# Author:  P$3ud0R@nD0m
# Version: 0.0.2

require_relative '../helpers/colorize'
require_relative 'menu'
require_relative 'dictionary'
require_relative '../tools/medusa'
require_relative '../tools/ncrack'

class BruteForce < Menu
  def menu
    header
    puts "Select a service to attack:".light_yellow
    puts "1.  CVS (Medusa)"
    puts "2.  FTP (Medusa)"
    puts "3.  HTTP(S) (Medusa)"
    puts "4.  IMAP (Medusa)"
    puts "5.  MSSQL (Medusa)"
    puts "6.  MYSQL (Medusa)"
    puts "7.  NCP (Medusa)"
    puts "8.  NNTP (Medusa)"
    puts "9.  PCANYWHERE (Medusa)"
    puts "10. POP3 (Medusa)"
    puts "11. POSTGRES (Medusa)"
    puts "12. REXEC (Medusa)"
    puts "13. RLOGIN (Medusa)"
    puts "14. RSH (Medusa)"
    puts "15. SMBNT (Medusa)"
    puts "16. SMTP-VRFY (Medusa)"
    puts "17. SMTP (Medusa)"
    puts "18. SNMP (Medusa)"
    puts "19. SSH (Medusa)"
    puts "20. SVN (Medusa)"
    puts "21. TELNET (Medusa)"
    puts "22. VMAUTHD (Medusa)"
    puts "23. VNC (Medusa)"
    puts "24. WEB-FORM (Medusa)"
    puts "88. Back"
    puts "99. Exit Gladius"

    sel = gets.to_i
    puts
    if sel == 1
      puts "Not implemented yet.".red
      menu
    elsif sel == 2
      puts "Not implemented yet.".red
      menu
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
      puts "Not implemented yet.".red
      menu
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
      Medusa.new("Medusa - SSH Brute Force").ssh
    elsif sel == 20
      puts "Not implemented yet.".red
      menu
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
    elsif sel == 9
      puts "Not implemented yet.".red
      menu
    elsif sel == 88
      Dictionary.new("Dictionary Attacks").menu
    elsif sel == 99
      begin
      puts "Exiting Gladius. Have a bloody day!".red
      rescue Interrupt
      end
    else
      puts "Invalid selection.".red
      menu
    end
  end
end

