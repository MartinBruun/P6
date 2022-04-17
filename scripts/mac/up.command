#!/bin/zsh

cd ..
cd ..
cd washee_app
flutter pub get
osascript -e 'tell application "System Events" to tell process "Terminal" to keystroke "t" using command down' > /dev/null
osascript -e "tell application \"Terminal\" to do script \"cd $PWD && flutter run --dart-define=ENVIRONMENT=DEV\" in window 1" > /dev/null
cd ..
docker-compose up -d --build
docker-compose exec web python3 manage.py flush --no-input
docker-compose exec web python3 manage.py makemigrations
docker-compose exec web python3 manage.py migrate
echo 
echo Loading users from ./washee_web/account/fixtures/init_priorgade_users.json
echo Loading accounts from ./washee_web/account/fixtures/init_priorgade_accounts.json
echo Loading machine models from ./washee_web/location/fixtures/init_priorgade_models.json
echo Loading services from ./washee_web/location/fixtures/init_priorgade_services.json
echo Loading locations from ./washee_web/location/fixtures/init_priorgade_locations.json
echo Loading machines from ./washee_web/location/fixtures/init_priorgade_machines.json
echo Loading bookings from ./washee_web/location/fixtures/init_priorgade_bookings.json
echo 
docker-compose exec web python3 manage.py loaddata init_priorgade_users.json init_priorgade_accounts.json init_priorgade_models.json init_priorgade_services.json init_priorgade_locations.json init_priorgade_machines.json init_priorgade_bookings.json
cd scripts
cd mac
echo 
echo The -- box -- container is accessible on localhost:8001/
echo The -- web -- container is accessible on localhost:8000/
echo The -- app -- flutter application is started in a seperate prompt on chrome
echo 
echo You can run the -- test_app.bat -- command to run tests for the mobile application
echo You can run the -- test_box.bat -- command to run tests for the box application
echo You can run the -- test_web.bat -- command to run tests for the web application
echo You can run the -- logs.bat ------ command to see the logs of the containers
echo 
echo REMEMBER to run the -- down.bat -- command to close the containers!
echo The flutter application should be shut down in the seperate prompt