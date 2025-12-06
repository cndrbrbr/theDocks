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
ARG Minecraft_Version=1.21.10
ARG Minecraft_Server="nc3"
USER root
RUN apt-get update --fix-missing -y
RUN apt-get -y upgrade 


WORKDIR /root
RUN mkdir /root/plugins             
RUN mkdir /root/customConfig
RUN mkdir /root/minecraftJar

COPY ./startscript.sh /root
COPY ./setupfiles.sh /root
COPY ./start.sh /root
# server folders
COPY ../../data/mcsrvbase.tgz /root
# server software
COPY ../../data/mcserversw/${Minecraft_Version}/* /root/minecraftJar
# server customizing and worlds
COPY ../../data/serverconfigs/${Minecraft_Server}/* /root/customconfig
# all plugins for Minecraft_Version
COPY ../../data/plugins/${Minecraft_Version}/*  /root/plugins
  
RUN chmod u+x /root/startscript.sh
RUN chmod u+x /root/setupfiles.sh
RUN chmod u+x /root/start.sh


ENTRYPOINT ["/bin/bash", "/root/startscript.sh"]
