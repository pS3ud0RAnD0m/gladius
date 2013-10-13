# Gladius
An interactive shell for common Kali Linux tasks

## Warning
This app is alpha, so beware. I'll be making significant changes over the next few months.

## Install
### Git Install
Change directory and clone:

`cd /opt;git clone https://github.com/pS3ud0RAnD0m/gladius`


Symlink:

`ln -s /opt/gladius/gladius.rb /usr/bin/gladius;cd`


Run from anywhere:

`gladius`

### .bz2 Install


Change to the directory that is holding gladius.tar.bz2:

`cd <dir/holding/gladius.tar.bz2>`


Move, unpack, and clean-up:

`mv gladius.tar.bz2 /opt;cd /opt;tar jxf /opt/gladius.tar.bz2;rm -f /opt/gladius.tar.bz2`


Symlink:

`ln -s /opt/gladius/gladius.rb /usr/bin/gladius;cd`


Run from anywhere:

`gladius`

## Update
### Git Update
Change to the gladius directory and pull the newest commit:

`cd /opt/gladius;git pull`
