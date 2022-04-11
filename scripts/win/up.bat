@ECHO off

cd ..
cd ..
cd washee_app
<<<<<<< HEAD
call start cmd /k flutter run
=======
call start cmd /k flutter run --dart-define=ENVIRONMENT=DEV
>>>>>>> ed9f811f3b5b714dc37914f37725668a7f2afcc0
cd ..
call docker-compose up -d --build
call docker-compose exec web python3 manage.py flush --no-input
call docker-compose exec web python3 manage.py makemigrations
call docker-compose exec web python3 manage.py migrate
echo.
echo Loading users from ./washee_web/account/fixtures/init_priorgade_users.json
call docker-compose exec web python3 manage.py loaddata init_priorgade_users.json
echo Loading accounts from ./washee_web/account/fixtures/init_priorgade_accounts.json
call docker-compose exec web python3 manage.py loaddata init_priorgade_accounts.json
echo Loading machine models from ./washee_web/location/fixtures/init_priorgade_models.json
call docker-compose exec web python3 manage.py loaddata init_priorgade_models.json
echo Loading services from ./washee_web/location/fixtures/init_priorgade_services.json
call docker-compose exec web python3 manage.py loaddata init_priorgade_services.json
echo Loading locations from ./washee_web/location/fixtures/init_priorgade_locations.json
call docker-compose exec web python3 manage.py loaddata init_priorgade_locations.json
echo Loading machines from ./washee_web/location/fixtures/init_priorgade_machines.json
call docker-compose exec web python3 manage.py loaddata init_priorgade_machines.json
echo Loading bookings from ./washee_web/location/fixtures/init_priorgade_bookings.json
call docker-compose exec web python3 manage.py loaddata init_priorgade_bookings.json
cd scripts
cd win
echo.
echo The -- box -- container is now accessible on localhost:8001/
echo The -- web -- container is now accessible on localhost:8000/
echo The -- app -- flutter application is started in a seperate prompt on chrome
echo.
echo You can run the -- test_app.bat -- command to run tests for the mobile application
echo You can run the -- test_box.bat -- command to run tests for the box application
echo You can run the -- test_web.bat -- command to run tests for the web application
echo.
echo REMEMBER to run the -- down.bat -- command to close the containers!
echo The flutter application should be shut down in the seperate prompt