#######################################################
# Run Evironment for Minecraft Server Files
# docker build -t mcsrvj22 .
# Start with docker-compose
#
# (c) 2022  Create (cndrbrbr)
# (c) 2025  Update detailed Volumes (cndrbrbr)
# - config var für verzeichnisname der serverconfig
# - handle image build and container build
#######################################################
FROM mcagjava22

USER root
RUN apt-get update --fix-missing -y
RUN apt-get -y upgrade 
RUN apt-get install -y openssh-client
RUN apt-get install -y inotify-tools
RUN apt-get install -y unzip

WORKDIR /root          
RUN mkdir /root/mcsrvbase

COPY minecraft/mcsrvj22/startscript.sh /root
COPY minecraft/mcsrvj22/setupfiles.sh /root
COPY minecraft/mcsrvj22/start.sh /root
COPY minecraft/mcsrvj22/customconfig.sh /root
COPY minecraft/mcsrvj22/expand.sh /root
COPY minecraft/mcsrvj22/watch_copy.sh /root
COPY minecraft/mcsrvj22/check_wildcard_file.sh /root
COPY minecraft/mcsrvj22/check_wildcard_folder.sh /root
COPY minecraft/mcsrvj22/copy_missing_world_archives.sh /root

  
RUN chmod ugo+x /root/startscript.sh
RUN chmod ugo+x /root/setupfiles.sh
RUN chmod ugo+x /root/start.sh
RUN chmod ugo+x /root/expand.sh 
RUN chmod ugo+x /root/watch_copy.sh 
RUN chmod ugo+x /root/customconfig.sh
RUN chmod ugo+x /root/check_wildcard_file.sh
RUN chmod ugo+x /root/check_wildcard_folder.sh
RUN chmod ugo+x /root/copy_missing_world_archives.sh 
RUN chmod ugo+rw -R /root/*




#ENTRYPOINT ["/bin/bash", "/root/startscript.sh"]
CMD ["sleep", "infinity"]