#!/bin/zsh

cd ..
cd ..
cd washee_app
osascript -e 'tell app "Terminal" to do script "cd developer/p6-washee/P6/washee_app/ && flutter run --dart-define=ENVIRONMENT=DEV"'
cd ..
docker-compose up -d --build
docker-compose exec web python3 manage.py flush --no-input
docker-compose exec web python3 manage.py makemigrations
docker-compose exec web python3 manage.py migrate
echo 
echo Loading users from ./washee_web/account/fixtures/init_priorgade_users.json
docker-compose exec web python3 manage.py loaddata init_priorgade_users.json
echo Loading accounts from ./washee_web/account/fixtures/init_priorgade_accounts.json
docker-compose exec web python3 manage.py loaddata init_priorgade_accounts.json
echo Loading machine models from ./washee_web/location/fixtures/init_priorgade_models.json
docker-compose exec web python3 manage.py loaddata init_priorgade_models.json
echo Loading services from ./washee_web/location/fixtures/init_priorgade_services.json
docker-compose exec web python3 manage.py loaddata init_priorgade_services.json
echo Loading locations from ./washee_web/location/fixtures/init_priorgade_locations.json
docker-compose exec web python3 manage.py loaddata init_priorgade_locations.json
echo Loading machines from ./washee_web/location/fixtures/init_priorgade_machines.json
docker-compose exec web python3 manage.py loaddata init_priorgade_machines.json
echo Loading bookings from ./washee_web/location/fixtures/init_priorgade_bookings.json
docker-compose exec web python3 manage.py loaddata init_priorgade_bookings.json
cd scripts
cd win
echo 
echo The -- box -- container is now accessible on localhost:8001/
echo The -- web -- container is now accessible on localhost:8000/
echo The -- app -- flutter application is started in a seperate prompt on chrome
echo
echo You can run the -- test_app.command -- command to run tests for the mobile application
echo You can run the -- test_box.command -- command to run tests for the box application
echo You can run the -- test_web.command -- command to run tests for the web application
echo
echo REMEMBER to run the -- down.command -- command to close the containers!
echo The flutter application should be shut down in the seperate prompt