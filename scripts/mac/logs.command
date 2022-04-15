cd ..
cd ..
docker-compose logs -t
cd scripts
cd mac
echo 
echo The -- box -- container is accessible on localhost:8001/
echo The -- web -- container is accessible on localhost:8000/
echo The -- app -- flutter application is started in a seperate prompt on chrome
echo 
echo You can run the -- test_app.command -- command to run tests for the mobile application
echo You can run the -- test_box.command -- command to run tests for the box application
echo You can run the -- test_web.command -- command to run tests for the web application
echo You can run the -- logs.command ------ command to see the logs of the containers
echo 
echo REMEMBER to run the -- down.command -- command to close the containers!
echo The flutter application should be shut down in the seperate prompt