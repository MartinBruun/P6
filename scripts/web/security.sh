#!/bin/sh

cd ..
cd ..
sudo docker-compose exec -f docker-compose.web.yml web python3 manage.py check --deploy
echo This shows if there are any known security vulnerabilities that should be handled.
cd scripts
cd web