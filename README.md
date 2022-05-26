# P6

This is the repository used for the bachelor project for the 6. Semester Software 2022, focusing on Cyber Physical Systems.

## What is it?
This project is created as an integrated system which makes it possible for apartment complexes to share the laundry room more efficiently, by making a booking system that integrates with the washing machines.
It also serves as a way to increase awareness of environmental impact, by presenting good times to do laundry in relation to the environment.

More information in how this project has been worked upon is presented in the (Wiki tab)[https://github.com/MartinBruun/P6/wiki], as well as an overview of the state of the project presented in (Projects)[https://github.com/MartinBruun/P6/projects/1]

## Features
The system consist of the following features, each handling a seperate part of the domain, and each having their own unique usecases:

`account`: The system manages your account information, can handle transactions and validate users.
`booking`: The system can create bookings which can be used to activate machines services.
`green_info`: The system calculates and present oppertune times to use different services.
`location`: The system works in physical locations, where you can redeem your bookings to activate them.

## How to run it
This repository contains 3 apps, a backend server, a box interacting with the laundry machines and a mobile app communicating between them. It also contains a database running on the same host as the backend.
Each folder relates to a seperate part of the project:
.github: contains Continious Integration Workflows and Issue Creation Tools
diagrams: contains all relevant diagrams and modellings of the application as a whole
nginx: contains a docker container to setup a proxy server on the production as well as HTTPS protection
scripts: contains all scripts that help in either development or operations
washee_app: contains flutter code for setting up the mobile app
washee_box: contains a docker container for setting up the box
washee_db: contains a docker container for setting up the database
washee_web: contains a docker container for setting up the backend
docker-compose.yml: The development docker-compose file starting up everything
docker-compose.web.yml: The production file for the backend

## Environment variables
The `.env.dev` file contains environment variables for development mode, while `.env.prod.web/app/box` contain specialized environment variables for running that singular application in production. When running a `docker-compose` command, the `.env.dev` is used as default. Presently, the `washee_app` is not dockerized (see below)

Please be aware that changing the environment variables should not be done lightly, since it changes the environment for all developers. This is an anti-pattern, and there should be a dedicated test environment (that is shared) and a developer environment (that is unique to each developer), but given the small amount of developers, it is argued it is not seen as necessary in the current iteration of the project.

### Developer mode
Before starting any of these commands, make sure to go into the Docker Dashboard, find Settings > Resources > Filesharing and then make sure that your computer give rights to the `P6` folder, otherwise some containers might not build.

To run the developer version, in the terminal go into `scripts/win/` or `scripts/mac/` depending on your operative system.
Then run the `up.bat` or `up.command` respectively.

This should start everything up (starting the docker-compose.yml file) and give you all the information you need.

### Production mode
Each app has its own seperate production ready docker-compose.NAME.yml file, which when run in the correct environment, will start a production ready build.

#### Web
To make a production ready server, it needs to run some form of linux and have enough memory/storage to run docker.

Presently, this does not work for any system with limited memory and storage (like a Raspberry Pi).
The current version runs on an Ubuntu, linux system with +1TB of storage and 16+ GB of ram.

To make the environment possible to run the server, you have to:
Install docker and docker-compose on your system.
Shut down any software using the ports 80 and 443 (http and https)
Port forward on your router, making it possible to let things going to port 80 and 443 go through the firewall
Run the `./init-letsencrypt.sh` script in the `/nginx` folder (this only needs to be run ones)
Create a `.env.prod.web` environment and a `.env.prod.db` environment at root level with correct variables in it.
The configuration of these files are secret and outside version control, so ask someone who knows what it should be.

To start the server, go to `/scripts/web` and run the `prod_up.sh` command. Run the `prod_down.sh` when you are done.
These scripts have been made to make sure that one does not mistype, and also works as a reference to the commands.

Checking for security concerns, seeing logs or reseting the database etc. is also possible to do as scripts.

#### Mobile
To make a production build for the mobile app, there are different ways of doing it depending on whether it is made for Android or IOS.

The following is made for the current iteration, where it is setup for a qucik way to get the software out into a user test environment. The proper way would be to create a pipeline getting on the Google and Apple Playstore.

For Android, go into the washee_app/ folder and run the `flutter build --release` command.
This creates an .apk file in `/washee_app/build/app/outputs/flutter-apk` which should be copied to the `washee_web/washee_web` folder. Then android phones can download the app through the websites `/download` url.

For IOS, you have to use XCode and create a TestFlight application, and use the tools and methods created by these to get it validated for testing by Apple.

#### Box
To make the box run in a production environment, get a raspberry pi.
The box then should also have two pins pr. machine being activated connected. These informations should be presented in the `washee_box/data_setup_files/setup_box.json`. When the information is presented in there in the given format, the box should be run up with the `python washee_box_entry.py` command, with thereafter visiting the `washeebox.local:8001/factoryreset` url on the network the box is running on, to make sure the box is factory reset to the information you have set in the `setup_box.json` file.
This iteration needs to migrate to a docker setup so it is more standardized, but this haven't been done due to time constraints.
