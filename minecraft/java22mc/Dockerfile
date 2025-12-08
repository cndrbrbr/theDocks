#######################################################
# Run Evironment for Minecraft Server Files
# docker build -t java17mc .
# Start with docker-compose
#
# (c) 2022  Create (cndrbrbr)
# (c) 2025  Update detailed Volumes (cndrbrbr)
# - config var für verzeichnisname der serverconfig
#######################################################
FROM mcagjava22
# env parameter which server aus compose
ARG Minecraft_Version
ARG Minecraft_Server
ARG servername
ARG levelname
ARG maxplayers
ARG spigot
ARG port
ARG sizes
ARG sizex



USER root
RUN apt-get update --fix-missing -y
RUN apt-get -y upgrade 


WORKDIR /root
RUN mkdir /root/plugins             
RUN mkdir /root/customconfig
RUN mkdir /root/minecraftjar
RUN mkdir /root/mcsrvbase

COPY minecraft/java22mc/startscript.sh /root
COPY minecraft/java22mc/setupfiles.sh /root
COPY minecraft/java22mc/start.sh /root
# server folders
COPY data/mcsrvbase/mcsrvbase.tgz /root/mcsrvbase
# server software
COPY data/mcserversw/${Minecraft_Version}/* /root/minecraftjar
# server customizing and worlds
COPY data/serverconfigs/${Minecraft_Server}/* /root/customconfig

# all plugins for Minecraft_Version
COPY data/plugins/${Minecraft_Version}/*  /root/plugins
  
RUN chmod ugo+x /root/startscript.sh
RUN chmod ugo+x /root/setupfiles.sh
RUN chmod ugo+x /root/start.sh
RUN chmod ugo+rw -R /root/*
RUN chmod ugo+x /root/customconfig/customconfig.sh

# .env erzeugen
RUN cat <<EOF > /root/.env
Minecraft_Version=${Minecraft_Version}
Minecraft_Server=${Minecraft_Server}
servername=${servername}
levelname=${levelname}
maxplayers=${maxplayers}
spigot=${spigot}
port=${port}
port=${port}
sizes=${sizes}
sizex=${sizex}
EOF


ENTRYPOINT ["/bin/bash", "/root/startscript.sh"]
#CMD ["sleep", "infinity"]