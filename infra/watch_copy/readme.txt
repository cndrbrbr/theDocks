#######################################################
# copy files of container to volume if changed
# (c) 2025 cndrbrbr
# 
#######################################################

apt install inotify-tools
chmod +x watch_copy.sh

./watch_copy.sh /path/to/source/file.txt /path/to/destination/
./watch_copy.sh /path/to/source/file.txt /path/to/destination/file.txt


./watch_copy.sh /home/mint/copytest/dirA/file.txt /home/mint/copytest/dirB/

screen -d -m -S watchcopy ./watch_copy.sh /home/mint/copytest/dirA/file.txt /home/mint/copytest/dirB/

