#!/bin/zsh

cd ..
docker-compose exec web pytest -vv
cd scripts