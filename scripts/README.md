# Scripts

These scripts start up the different applications.

The scripts in `win` and `mac` startup the development applications.
The scripts in `web`, `box` and `app` startup the production applications.

## Dev
The computer should have `docker` and `flutter` installed, but should otherwise work without problems.

The script startup the containers in the docker-compose file, and also starts the development server for the mobile flutter application in a seperate window.

`up` starts the application, `test_*` tests a specific application when it is running and `down` tears them down.

## App
SPECIFY HARDWARE CONDITIONS TO RUN SCRIPTS

SPECIFY WHAT THE SCRIPT(S) DO

## Box
SPECIFY HARDWARE CONDITIONS

SPECIFY WHAT THE SCRIPT(S) DO

## Web
SPECIFY HARDWARE CONDITIONS

The `web_prod_up` script starts the production server, and makes it listen to port 80 for incoming requests.
The `web_prod_down` script stops the production server, but makes sure it does not erase any data.