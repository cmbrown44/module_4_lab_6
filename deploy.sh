#!/bin/bash

# Create Network
docker network create trio-task-network2

# Build Images
docker build -t trio-task-mysql:5.7 db
docker build -t trio-task-flask-app:latest flask-app

# Run mysql container
docker run -d \
    --name mysql \
    --network trio-task-network \
    trio-task-mysql:5.7

# Run flask-app container
docker run -d \
    -e MYSQL_ROOT_PASSWORD=password \
    --name flask-app \
    --network trio-task-network \
    trio-task-flask-app:latest

# Run nginx container
docker run -d \
    --name nginx \
    -p 5000:5000 \
    --network trio-task-network \
    --mount type=bind,source=$(pwd)/nginx/nginx.conf,target=/etc/nginx/nginx.conf \
    nginx:latest


# show running containers
echo
docker ps -a