@ECHO off

cd ..
cd ..
echo ------------ WARNING !!!!! ------------
echo To run the integrationtests you need:
echo 1: A running android emulator OR android device connected
echo 2: All docker containers up and running
echo ------------ Run Box Unit Tests ------------
call docker-compose exec box python3 -m pytest -vv
echo ------------ Run Web Unit Tests ------------
call docker-compose exec web pytest -vv
cd washee_app
echo ------------ Run App Unit Tests ------------
call flutter test
echo ------------ Run Integration Tests ----
call flutter clean
call flutter pub get
call flutter test integration_test
cd ..
cd scripts
cd win