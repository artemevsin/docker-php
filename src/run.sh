#!/bin/bash
if [[ $(docker ps -a -q) ]]; then
  docker stop $(docker ps -a -q)
else
  echo "No running containers"
fi
if [[ $(docker ps -a -q) ]]; then
  docker rm -f $(docker ps -a -q)
else
  echo "There are no containers"
fi
docker-compose up -d