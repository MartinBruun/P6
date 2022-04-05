#!/bin/sh

cd ..
cd ..
docker-compose -f docker-compose.web.yml down
cd scripts
cd web
echo "Production server is now closed down"