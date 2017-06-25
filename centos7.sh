#!/bin/bash

systemctl stop firewalld.service 
systemctl disable firewalld.service
 
  if ! yum groupinstall "X Window System" -y
  then
  exit_script "X Window System"
  fi
   yum install gnome-classic-session gnome-terminal nautilus-open-terminal control-center liberation-mono-fonts -y
   unlink /etc/systemd/system/default.target
   ln -sf /lib/systemd/system/graphical.target /etc/systemd/system/default.target
  if ! yum install tigervnc-server -y
  then
    exit_script "tigervnc-server"
  fi
  cp /lib/systemd/system/vncserver@.service /lib/systemd/system/vncserver@\:1.service
  sed -i 's/%i/:1/g' /lib/systemd/system/vncserver@\:1.service
  sed -i 's/<USER>/root/g' /lib/systemd/system/vncserver@\:1.service
  sed -i 's/home\/root/root/g' /lib/systemd/system/vncserver@\:1.service
  vncpasswd
 
  systemctl enable vncserver@:1.service
  systemctl start vncserver@:1.service
  systemctl status vncserver@:1.service
  systemctl disable initial-setup-text.service

