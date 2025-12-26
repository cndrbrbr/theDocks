#!/bin/bash
#######################################################
# build Docker container
# (c) 2025 cndrbrbr
# scp -r -i .\cloud_key -P 2222 .\data\* user1@192.168.115.135:upload/
#######################################################
docker compose up -d --build