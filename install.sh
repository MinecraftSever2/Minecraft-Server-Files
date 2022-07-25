#!/bin/bash

NOCOLOR="\033[0m"
COLOR="\033[1;33m"

SERVERFILESDIR="server"
PLUGINSDIR="plugins"
DATAPACKDIR="datapacks"

SPIGOTVER="spigot-1.19.jar"
DIFFICULTY="normal"

function download_java {
	echo -e "${COLOR}Downloading Java${NOCOLOR}"
	apt -qq update
	apt -qq install openjdk-17-jdk
}

function download_spigot {
	echo ""
	if test -f $SPIGOTVER
	then
		echo -e "${COLOR}Spigot is already downloaded${NOCOLOR}"
	else
		echo -e "${COLOR}Downloading Spigot${NOCOLOR}"
		wget "https://download.getbukkit.org/spigot/$SPIGOTVER"
	fi
}

function startup {
	echo -e "${COLOR}First startup${NOCOLOR}"
	java -jar $SPIGOTVER
	sed -i "s/false/true/g" "./eula.txt"
	sed -i "s/difficulty=easy/difficulty=${DIFFICULTY}/g" "./server.properties"
	sed -i "s/white-list=false/white-list=true/g" "./server.properties"
	java -jar $SPIGOTVER
	mv ../$PLUGINSDIR/* "./plugins"
	mv ../$DATAPACKSDIR/* "./world/datapacks"
}
function main {
	echo -e "${COLOR}Starting configuration process${NOCOLOR}"
	mkdir $SERVERFILESDIR
	cd $SERVERFILESDIR
	download_java
	download_spigot
	startup
	echo -e "${COLOR}Instalation completed${NOCOLOR}"
}

main
