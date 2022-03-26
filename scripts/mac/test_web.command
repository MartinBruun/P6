#!/bin/zsh

cd ..
cd ..
docker-compose exec web pytest -vv
cd scripts
cd mac