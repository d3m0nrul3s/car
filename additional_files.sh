#!/bin/bash
function check(){
  read -p 'What is your system
  1) Final arch
  2) Final debian 
  Number your system: ' name
  if [ "$name" == "1" ]; then
    cp -rv /usr/bin/cat /usr/bin/cat
    cp -rv /usr/bin/bat /usr/bin/cat
    chmod +x strap.sh
    sudo bash strap.sh
    sudo pacman -Sy
    sudo pacman -S nmap crackmapexec metasploit exploitdb proxychains exploit-db gobuster burpsuite whatweb wfuzz hydra smbmap smbclient mpv
  else
    if [ "$name" == "2" ]; then
      cp -rv /usr/bin/cat /usr/bin/cat
      cp -rv /usr/bin/batcat /usr/bin/cat
      apt update 
      apt install mpv gobuster xclip
  else
    echo "One or Two !!!!!!!!"; check
  fi
  fi
}

check