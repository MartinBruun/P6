@ECHO off

cd ..
cd ..
call docker-compose exec box python3 -m pytest -vv
cd scripts
cd win