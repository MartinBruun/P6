@ECHO off

cd ..
cd ..
echo ------------ Only runs Unit and Widget tests! ------------
call docker-compose exec web pytest -vv
cd scripts
cd win