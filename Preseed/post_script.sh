#!/bin/bash

apt update
if [[ $(cat /proc/scsi/scsi) =~ "VMware" ]]; then
	apt install -y open-vm-tools open-vm-tools-desktop
fi

if [[ $(dpkg --get-selections) =~ "xubuntu" ]]; then
	apt install -y xfce4-terminal gedit
	mkdir -p /home/oai/Desktop
	chmod 777 /home/oai/Desktop
	cp /usr/share/applications/exo-terminal-emulator.desktop /home/oai/Desktop/exo-terminal-emulator.desktop
	chmod +x /home/oai/Desktop/exo-terminal-emulator.desktop
	chown oai /home/oai/Desktop/exo-terminal-emulator.desktop
	echo -e \
"[SeatDefaults]
autologin-user=oai
autologin-user-timeout=0" \
	| tee -a /etc/lightdm/lightdm.conf.d/default.conf
	echo -e \
'<?xml version="1.0" encoding="UTF-8"?>

<channel name="xfce4-panel" version="1.0">
  <property name="panels" type="uint" value="1">
    <property name="panel-0" type="empty">
      <property name="position" type="string" value="p=4;x=0;y=0"/>
      <property name="length" type="uint" value="100"/>
      <property name="position-locked" type="bool" value="true"/>
      <property name="plugin-ids" type="array">
        <value type="int" value="1"/>
        <value type="int" value="2"/>
        <value type="int" value="3"/>
        <value type="int" value="4"/>
      </property>
      <property name="background-style" type="uint" value="0"/>
      <property name="background-alpha" type="uint" value="80"/>
      <property name="size" type="uint" value="24"/>
      <property name="length-adjust" type="bool" value="true"/>
      <property name="span-monitors" type="bool" value="false"/>
      <property name="enter-opacity" type="uint" value="100"/>
      <property name="leave-opacity" type="uint" value="100"/>
      <property name="mode" type="uint" value="0"/>
      <property name="autohide-behavior" type="uint" value="0"/>
    </property>
  </property>
  <property name="plugins" type="empty">
    <property name="plugin-1" type="string" value="applicationsmenu">
      <property name="show-button-title" type="bool" value="false"/>
    </property>
    <property name="plugin-2" type="string" value="tasklist">
      <property name="flat-buttons" type="bool" value="true"/>
    </property>
    <property name="plugin-3" type="string" value="separator">
      <property name="style" type="uint" value="0"/>
      <property name="expand" type="bool" value="true"/>
    </property>
    <property name="plugin-4" type="string" value="clock">
      <property name="digital-format" type="string" value="%d %b, %H:%M"/>
    </property>
    
  </property>
  <property name="configver" type="int" value="2"/>
</channel>' \
	| tee /etc/xdg/xdg-xubuntu/xfce4/panel/default.xml
	echo -e \
'<?xml version="1.0" encoding="UTF-8"?>

<channel name="xfce4-desktop" version="1.0">
  <property name="desktop-icons" type="empty">
    <property name="style" type="int" value="2"/>
    <property name="file-icons" type="empty">
      <property name="show-filesystem" type="bool" value="false"/>
      <property name="show-trash" type="bool" value="false"/>
      <property name="show-unknown-removable" type="bool" value="false"/>
    </property>
    <property name="icon-size" type="uint" value="48"/>
    <property name="tooltip-size" type="double" value="64.000000"/>
  </property>
  <property name="backdrop" type="empty">
    <property name="screen0" type="empty">
      <property name="monitor0" type="empty">
        <property name="image-path" type="string" value="/usr/share/xfce4/backdrops/xubuntu-wallpaper.png"/>
        <property name="image-style" type="int" value="5"/>
        <property name="image-show" type="bool" value="true"/>
      </property>
    </property>
  </property>
</channel>' \
  | tee /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml 
fi

echo "git clone --depth=1 https://github.sydney.edu.au/wzha2887/Linux_Script.git" > /home/oai/.bash_history
chown oai /home/oai/.bash_history
chmod 600 /home/oai/.bash_history

