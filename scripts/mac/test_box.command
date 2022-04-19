#!/bin/zsh

cd ..
cd ..
docker-compose exec box python3 -m pytest -vv
cd scripts
cd mac