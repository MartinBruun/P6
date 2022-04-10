@ECHO off

cd ..
cd ..
call docker-compose exec box pytest -vv
cd scripts
cd win