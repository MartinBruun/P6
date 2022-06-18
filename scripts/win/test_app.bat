@ECHO off

cd ..
cd ..
cd washee_app
echo ------------ Only runs Unit and Widget tests! ------------
call flutter test
cd ..
cd scripts
cd win