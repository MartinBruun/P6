@ECHO off

cd ..
cd ..
call docker-compose up -d --build
call docker-compose exec web python3 manage.py flush --no-input
call docker-compose exec web python3 manage.py makemigrations
call docker-compose exec web python3 manage.py migrate
call docker-compose exec web python3 manage.py loaddata init_priorgade_users.json
call docker-compose exec web python3 manage.py loaddata init_priorgade_accounts.json
call docker-compose exec web python3 manage.py loaddata init_priorgade_models.json
call docker-compose exec web python3 manage.py loaddata init_priorgade_services.json
call docker-compose exec web python3 manage.py loaddata init_priorgade_locations.json
call docker-compose exec web python3 manage.py loaddata init_priorgade_machines.json
call docker-compose exec web python3 manage.py loaddata init_priorgade_bookings.json
cd washee_app
call start cmd /k flutter run --dart-define=ENVIRONMENT=DEV
cd ..
cd scripts
cd win
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