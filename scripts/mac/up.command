#!/bin/zsh

cd ..
cd ..
docker-compose up -d --build
cd washee_app
echo MISSING COMMAND TO START FLUTTER! CD INTO WASHEE_APP AND RUN flutter run -d chrome
cd ..
cd scripts
cd mac
echo The -- box -- container is now accessible on localhost:8001/
echo The -- web -- container is now accessible on localhost:8000/
echo The -- app -- flutter application is started in a seperate prompt on chrome
echo.
echo You can run the -- test_app.command -- command to run tests for the mobile application
echo You can run the -- test_box.command -- command to run tests for the box application
echo You can run the -- test_web.command -- command to run tests for the web application
echo.
echo REMEMBER to run the -- down.command -- command to close the containers!
echo The flutter application should be shut down in the seperate prompt