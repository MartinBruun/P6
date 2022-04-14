#!/bin/sh

cd ..
cd ..
sudo docker-compose -f docker-compose.web.yml up -d --build
sudo docker-compose -f docker-compose.web.yml exec web python3 manage.py migrate --noinput
sudo docker-compose -f docker-compose.web.yml exec web python3 manage.py collectstatic --no-input
cd scripts
cd web
echo "You now run a production build on https://www.emilbruun.dk"
echo "Remember to run prod_down.bat to safely close the containers and persist data"
