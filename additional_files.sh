#!/bin/bash
function check(){
  read -p '
  ---------------
  1) Final arch
  ---------------
  2) Final debian
  ---------------
  -> ' name
  if [ "$name" == "1" ]; then
    cp -rv /usr/bin/cat /usr/bin/ca
    cp -rv /usr/bin/bat /usr/bin/cat
    chmod +x strap.sh
    sudo bash strap.sh
    bash test_file.sh
    sudo pacman -Sy
    sudo pacman -S nmap crackmapexec metasploit exploitdb proxychains exploit-db gobuster burpsuite whatweb wfuzz hydra smbmap smbclient mpv
  else
    if [ "$name" == "2" ]; then
      apt update
      apt install mpv gobuster xclip bat btop xinput
      cp -rv /usr/bin/cat /usr/bin/cat
      cp -rv /usr/bin/bat /usr/bin/cat
      chmod +x scripts/*
      cp -rv scripts/* /usr/bin/
  else
    echo "What the fuck... it's hard to fucking choose one or two....!!!!!!!!"; check
  fi
  fi
}

check
