#!/bin/sh

cd ..
cd ..
sudo docker-compose -f docker-compose.web.yml down -v
cd scripts
cd web
echo "Production server has now been reset with all data"
