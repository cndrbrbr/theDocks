#######################################################
# Run Evironment for Minecraft Server Files
# docker build -t baremc22 .
# Start with docker-compose bareJavaMC
#
# (c) 2022  Create (cndrbrbr)
# (c) 2025  Update detailed Volumes (cndrbrbr)
# - config var für verzeichnisname der serverconfig
#######################################################
FROM mcagjava22

USER root
RUN apt-get update --fix-missing -y
RUN apt-get -y upgrade 
# für ss -tulpen
RUN apt-get install -y iproute2
RUN apt install -y openssh-client
WORKDIR /root



#ENTRYPOINT ["/bin/bash", "/root/startscript.sh"]
CMD ["sleep", "infinity"]