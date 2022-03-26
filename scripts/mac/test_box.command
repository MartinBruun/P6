#!/bin/zsh

cd ..
cd ..
docker-compose exec box pytest -vv
cd scripts
cd mac