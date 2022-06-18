cd ..
cd ..
cd washee_app
call flutter clean
call flutter pub get
call flutter build apk --release
call flutter install
cd ..
cd scripts
cd app