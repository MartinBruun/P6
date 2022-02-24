# P6

This is the repository used for the bachelor project for the 6. Semester Software 2022
This description should be replaced with a proper presentation, when it has been done.

## What do we want?
Give short descriptions of what we want out of the bachelor project, if any:

## How to run it
This repository contains 3 apps and a database.

### Developer mode
Before starting any of these commands, make sure to go into the Docker Dashboard, find Settings > Resources > Filesharing and then make sure that your computer give rights to the `P6` folder, otherwise some containers might not build.

Also, be sure to know that the developer container uses up towards `3 GB` of space, primarily because of the mobile image!

To run all apps in developer mode, simply write:

`docker-compose build`
`docker-compose up`
OR
`docker-compose up --build`

To shut the containers down, simply write:

`docker-compose down -v`

The `-v` option signals that all volumes should be removed. To persist data between runs, simply omit the option.

To run a container by its own, write:

`docker-compose run app`
OR
`docker-compose run box`
OR
`docker-compose run web`

The `web` container will automatically start the `db` container, because it is linked to it. 

To access the different applications, open the browser and go into:

app: localhost:9000
web: localhost:8000
box: localhost:5000

### Production mode
Each app has its own seperate production ready docker-compose.NAME.yml file, which when run in the correct environment, will start a production ready build.

#### Web
HOW TO

#### Mobile
HOW TO

#### Box
HOW TO