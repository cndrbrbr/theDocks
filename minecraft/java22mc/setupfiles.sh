#!/bin/bash
#######################################################
# Setup Minecraft Servers Java
#
# (c) 2025 cndrbrbr
#######################################################

# create custom minecraft folder
if [[ ! -d "/root/mcsrvbase/data/cfg" ]]; then
    cd /root/mcsrvbase
    echo "mcsrvbase-Daten fehlen – entpacke mcsrvbase.tgz ..."
    tar -xvf mcsrvbase.tgz 
else
    echo "mcsrvbase/data ist bereits vorhanden – kein Entpacken nötig."
fi

cd /root
# /root/mcsrvbase exists
# copy minecraft jar
cp /root/minecraftjar/* /root/mcsrvbase
cp /root/start.sh /root/mcsrvbase

# copy plugins and configure server
/root/customconfig/customconfig.sh


