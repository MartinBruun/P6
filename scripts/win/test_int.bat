@ECHO off

cd ..
cd ..
cd washee_app
call flutter clean
call flutter pub get
call flutter test integration_test
cd ..
cd scripts
cd win