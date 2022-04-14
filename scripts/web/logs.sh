#!/bin/sh

cd ..
cd ..
call docker-compose -f docker-compose.web.yml logs -t
cd scripts
cd web