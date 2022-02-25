# P6

This is the repository used for the bachelor project for the 6. Semester Software 2022
This description should be replaced with a proper presentation, when it has been done.

## What do we want?
Give short descriptions of what we want out of the bachelor project, if any:

## How to run it
This repository contains 3 apps and a database.

## Environment variables
The `.env.dev` file contains environment variables for development mode, while `.env.prod.web/app/box` contain specialized environment variables for running that singular application in production. When running a `docker-compose` command, the `.env.dev` is used as default. Presently, the `washee_app` is not dockerized (see below)

Please be aware that changing the environment variables should not be done lightly, since it changes the environment for all developers. This is an anti-pattern, and there should be a dedicated test environment (that is shared) and a developer environment (that is unique to each developer), but given the small amount of developers, it is argued it is not seen as necessary in the current iteration of the project.

### Developer mode
Before starting any of these commands, make sure to go into the Docker Dashboard, find Settings > Resources > Filesharing and then make sure that your computer give rights to the `P6` folder, otherwise some containers might not build.

To run the web and box apps in developer mode, be in the root directory of the `P6` project, and simply write:

`docker-compose build`
`docker-compose up`
OR
`docker-compose up --build`

To shut the containers down, simply write:

`docker-compose down -v`

The `-v` option signals that all volumes should be removed. To persist data between runs, simply omit the option.

To access the different applications, open the browser and go into:

box: localhost:8001
web: localhost:8000

To run the mobile application, first install flutter, then write:

`cd washee_app`
`flutter run`

This should give you the option to start the app in Edge or Chrome.
If possible, flutter should also be able to be dockerized, but presently it is not needed and takes up too much space.

### Production mode
Each app has its own seperate production ready docker-compose.NAME.yml file, which when run in the correct environment, will start a production ready build.

#### Web
To make a production ready server, create a `.env.prod.web` and a `.env.prod.db` file in the root directory.
The configuration of these files are secret and outside version control, so ask someone who knows what it should be.

To start the production server
`docker-compose -f docker-compose.web.yml up -d --build`

To see the logs
`docker-compose -f docker-compose.web.yml logs -f`

#### Mobile
HOW TO

#### Box
HOW TO