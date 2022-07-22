#!/bin/bash

echo "Starting configuration process"

# MAINDIR="MinecraftServer"
SERVERFILESDIR="server"
PLUGINSDIR="plugins"
DATAPACKDIR="terralith"

SPIGOTVER="spigot-1.19.jar"

# echo "Clonning from github"
# git clone git@github.com:MinecraftSever2/Minecraft-Sever-Files.git $MAINDIR 
# cd $MAINDIR

mkdir $SERVERFILESDIR
cd $SERVERFILESDIR

echo "Downloading Java"
apt update
apt install openjdk-17-jdk

echo "Downloading Spigot"
wget "https://download.getbukkit.org/spigot/$SPIGOTVER"

echo "First startup"
java -jar $SPIGOTVER
sed -i "s/false/true/g" "./eula.txt"
mv "../$PLUGINSDIR" "./plugins"
java -jar $SPIGOTVER
