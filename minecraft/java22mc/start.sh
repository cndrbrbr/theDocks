#!/bin/bash
#######################################################
# Start Minecraft Server 
#
# (c) 2022 cndrbrbr
# (c) 2025 cndrbrbr commandlineparameter, 
#					volumes, 
#					keep on running
# chmod +x start.sh
#######################################################

servername="nc3"
levelname="world"
maxplayers=5
spigot="spigot-1.21.10.jar"
#host="localhost"
port=25566
	 #-jar $spigot \   	--initSettings \

cd /root/mcsrvbase
echo "eula=true" > eula.txt
while true; do
    echo "Starte Minecraft..."

	java -Xms1G -Xmx1G \
	-Dfile.encoding=UTF-8 \
	-jar $spigot \
	--bukkit-settings "./data/cfg/bukkit.yml" \
	--spigot-settings "./data/cfg/spigot.yml" \
	--commands-settings "./data/cfg/commands.yml" \
	--config "./data/cfg/server.properties" \
	--port "$port" \
	--level-name "$levelname" \
	--max-players "$maxplayers" \
	--online-mode "true" \
	--plugins "./data/plugins" \
	--serverId "$servername" \
	--world-dir "./data/worlds" \
	nogui

	EXIT_CODE=$?
    echo "Server gestoppt mit Code $EXIT_CODE"

    # Wenn der Server *normal* beendet wurde (z. B. /stop)
    # -> nicht automatisch neu starten
    if [[ $EXIT_CODE -eq 0 ]]; then
        echo "Normaler Stop - kein Neustart."
        break
    fi

    echo "Crash erkannt - Neustart in 5 Sekunden..."
    sleep 5
done


#	#--host "$host" \
