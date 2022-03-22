#!/bin/zsh

cd ..
docker-compose exec box pytest -vv
cd scripts