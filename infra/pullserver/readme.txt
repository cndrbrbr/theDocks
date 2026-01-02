###############################################
# pullserver for delivering costomizing data
#
# user and config data stored frequently
# to update server software on the fly
# (c) 2025 cndrbrbr
###############################################
use rights for user1

mkdir /srv/cloud
mkdir /srv/sshkeys

copy cloud_key and cloud_key.pub
to /srv/sshkeys

chmod 700 /srv/sshkeys
chmod 600 /srv/sshkeys/cloud_key
chmod 644 /srv/sshkeys/cloud_key.pub

Presumed Folder Structure of pullserver
.
├── cloud
│   ├── mcsoftware
│   │   ├── bungee
│   │   └── server
│   ├── plugins
│   │   ├── 1.14.4
│   │   └── 1.21.10
│   ├── servers
│   │   ├── ehle25
│   │   │      worlds.txt
│   │   │      plugins.txt
│   │   │      serverconfig.tgz
│   │   ├───── pluginconfig
│   │   │        <pluginname>.tgz
│   │   ├── hard
│   │   ├── mctown
│   │   ├── meckminecraft
│   │   ├── multivitamin
│   │   ├── scriptcraft
│   │   ├── soft
│   │   └── weih24
│   └── worlds
│         <date>-<time>-<servername>-<worldname>.tgz
└── sshkeys

servers contain
- worlds.txt = list of worlds
- plugins.txt = list of plugins
- pluginconfig - zipped plugin folders
- serverconfig.tgz = configfiles of the server

auf dem client
scp -r -i .\cloud_key -P 2222 .\data\* user1@192.168.115.135:./

scp -r -i .\cloud_key -P 2222 user1@192.168.115.135:./test.txt .\data\test.txt

scp -i /keys/cloud_key -P 2222 -o StrictHostKeyChecking=no user1@192.168.115.135:./test.txt ./test.txt

scp -i /keys/cloud_key -P 2222 \
    -o StrictHostKeyChecking=no \
    user1@192.168.115.135:./test.txt ./test.txt

