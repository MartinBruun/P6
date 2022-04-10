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

To see the logs if anything goes wrong
`docker-compose -f docker-compose.web.yml logs -f`

#### Mobile
HOW TO

#### Box
HOW TO
