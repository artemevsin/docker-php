#!/bin/bash

if [[ $(docker network ls -f name=proxynet | grep -w proxynet) ]]; then
  echo "Network proxynet already exists"
else
  echo "Creating network: proxynet"
  $(docker network create --driver=bridge proxynet)
fi

if [[ $(docker ps -f name=nginx-proxy-net | grep -w nginx-proxy-net) ]]; then
  echo "Nginx already running"
else
  echo "Start Nginx"
  if [[ $(docker ps -a -f name=nginx-proxy-net | grep -w nginx-proxy-net) ]]; then
    $(docker start nginx-proxy-net)
  else
    docker run -d --network=proxynet --name=nginx-proxy-net -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro -v $(pwd)/my_proxy.conf:/etc/nginx/conf.d/my_proxy.conf:ro jwilder/nginx-proxy
  fi
fi

echo $(pwd)
if [[ ! -f ./../../docker-compose-local.yml ]]; then
    DOCKER_COMPOSE_LOCAL=./../artemevsin/docker/src/docker-compose-local.yml
else
    DOCKER_COMPOSE_LOCAL=./../../docker-compose-local.yml
fi
docker-compose -f $DOCKER_COMPOSE_LOCAL up -d --force-recreate --build