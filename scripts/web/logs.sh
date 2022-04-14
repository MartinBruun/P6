#!/bin/sh

cd ..
cd ..
sudo docker-compose -f docker-compose.web.yml logs -t
cd scripts
cd web