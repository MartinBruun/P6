@ECHO off

cd ..
cd ..
echo ------------ Only runs Unit and Widget tests! ------------
call docker-compose exec box python3 -m pytest -vv
cd scripts
cd win