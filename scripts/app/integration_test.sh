#!/bin/zsh

cd washee_app
flutter drive --driver=test_driver/android_driver.dart --target=integration_test/account_test.dart
cd ..