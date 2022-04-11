@ECHO off

cd ..
cd ..
call docker-compose exec web pytest -vv
cd scripts
cd win