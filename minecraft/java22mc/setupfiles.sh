#!/bin/bash
#######################################################
# Setup Minecraft Servers Java
#
# (c) 2025 cndrbrbr
#######################################################

cd /root
# create custom minecraft folder
tar xvfz mcsrvbase.tgz 
# /root/mcsrvbase exists
# copy minecraft jar
cp /root/minecraftJar/* /root/mcsrvbase
cp /root/start.sh /root/mcsrvbase

# copy plugins and configure server
/root/customconfig.sh


