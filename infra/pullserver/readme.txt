
mkdir /srv/cloud
mkdir /srv/sshkeys

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
scp -r -i .\cloud_key -P 2222 .\data\* user1@192.168.115.135:upload/
