#!/bin/bash
#######################################################
# Setup Minecraft Servers Java at runtime
# mcsrvj22
# (c) 2025 cndrbrbr
#  - use pullserver
#######################################################

SCP_BASE='scp -i /keys/cloud_key -P 2222 -o StrictHostKeyChecking=no user1@192.168.115.135:'
serverdatakey='ehle25'
minecraftversion='1.21.10'
serverfilename='spigot-1.21.10.jar'


#################################
# 0 create custom minecraft folder
#################################
cd /root
scp -i /keys/cloud_key -P 2222 -o StrictHostKeyChecking=no user1@192.168.115.135:./mcsrvbase/mcsrvbase.tgz ./mcsrvbase/mcsrvbase.tgz

if [[ ! -d "/root/mcsrvbase/data/cfg" ]]; then
    cd /root/mcsrvbase
    echo "mcsrvbase-Daten fehlen – entpacke mcsrvbase.tgz ..."
    tar -xvf mcsrvbase.tgz 
else
    echo "mcsrvbase/data ist bereits vorhanden – kein Entpacken nötig."
fi

#################################
# 1 copy minecraft software
#################################
cd /root
$SCP_BASE"./mcsoftware/server/${minecraftversion}/${serverfilename}" /root/mcsrvbase
cp /root/start.sh /root/mcsrvbase

#################################
# 2 copy config files
#################################
$SCP_BASE"./servers/${serverdatakey}/config.*" /root/mcsrvbase/data/cfg
/root/expand.sh /root/mcsrvbase/data/cfg
cp /root/mcsrvbase/data/cfg/whitelist.json /root/mcsrvbase
cp /root/mcsrvbase/data/cfg/banned-players.json /root/mcsrvbase
# hier das copy_touchscript starten
# 2Do
screen -d -m -S watchcopyWL ./watch_copy.sh /root/mcsrvbase/whitelist.json /root/mcsrvbase/data/cfg/whitelist.json
screen -d -m -S watchcopyBP ./watch_copy.sh /root/mcsrvbase/banned-players.json /root/mcsrvbase/data/cfg/banned-players.json

#################################
# 3 copy plugin software
# 4 copy plugin custom  folders
#################################
$SCP_BASE"./servers/${serverdatakey}/pluginconfig/plugins.txt" /root/mcsrvbase/data/plugins
FILE="/root/mcsrvbase/data/plugins/plugins.txt"
while IFS= read -r word; do
    echo "Word: $word"
    $SCP_BASE"./plugins/${minecraftversion}/${word}*.*" /root/mcsrvbase/data/plugins
    $SCP_BASE"./servers/${serverdatakey}/pluginconfig/${word}*.*" /root/mcsrvbase/data/plugins
done < "$FILE"

/root/expand.sh /root/mcsrvbase/data/plugins


#################################
# 5 copy worlds
#################################

$SCP_BASE"./servers/${serverdatakey}/worlds/*.*" /root/mcsrvbase/data/worlds
/root/expand.sh /root/mcsrvbase/data/worlds


#################################
# 6 .env File schreiben
#################################
set -eu

# Ziel für die .env im Container (anpassen, wo deine App sie erwartet)
ENV_FILE="${ENV_FILE:-/root/.env}"
#mkdir -p "$(dirname "$ENV_FILE")"

# (Optional) nur diese Keys schreiben (Whitelist), damit nix “aus Versehen” reinkommt
cat > "$ENV_FILE" <<EOF
minecraftversion=${minecraftversion:-}
servertech=${servertech:-}
serverdatakey=${serverdatakey:-}
serverfilename=${serverfilename:-}
servername=${servername:-}
levelname=${levelname:-}
onlinemode=${onlinemode:-}
maxplayers=${maxplayers:-}
port=${port:-}
sizes=${sizes:-}
sizex=${sizex:-}
EOF

chmod 600 "$ENV_FILE" || true

# Dein normaler Start (CMD aus Dockerfile / compose)
exec "$@"


