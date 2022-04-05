#!/bin/sh

cd ..
cd ..
docker-compose -f docker-compose.web.yml up -d --build
docker-compose -f docker-compose.web.yml exec web python manage.py migrate --noinput
docker-compose -f docker-compose.web.yml exec web python manage.py collectstatic --no-input
cd scripts
cd web
echo "You now run a production build on http://localhost/"
echo "Remember to run prod_down.bat to safely close the containers and persist data"