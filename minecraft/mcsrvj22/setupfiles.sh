#!/bin/bash
#######################################################
# Setup Minecraft Servers Java
# mcsrvj22
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

# server folders
scp -r -i /keys/cloud_key -P 2222 user1@192.168.115.135:./upload/mcsrvbase .\u\test.txt
cp data/mcsrvbase/mcsrvbase.tgz /root/mcsrvbase
# server software
cp data/mcserversw/${Minecraft_Version}/* /root/minecraftjar
# server customizing and worlds
cp data/serverconfigs/${Minecraft_Server}/* /root/customconfig

# all plugins for Minecraft_Version
cp data/plugins/${Minecraft_Version}/*  /root/plugins

# copy plugins and configure server
/root/customconfig/customconfig.sh


set -eu

# Ziel für die .env im Container (anpassen, wo deine App sie erwartet)
ENV_FILE="${ENV_FILE:-/root/.env}"
#mkdir -p "$(dirname "$ENV_FILE")"

# (Optional) nur diese Keys schreiben (Whitelist), damit nix “aus Versehen” reinkommt
cat > "$ENV_FILE" <<EOF
Minecraft_Version=${Minecraft_Version:-}
Minecraft_Server=${Minecraft_Server:-}
servername=${servername:-}
levelname=${levelname:-}
maxplayers=${maxplayers:-}
spigot=${spigot:-}
port=${port:-}
sizes=${sizes:-}
sizex=${sizex:-}
EOF

chmod 600 "$ENV_FILE" || true

# Dein normaler Start (CMD aus Dockerfile / compose)
exec "$@"


