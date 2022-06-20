#!/bin/bash

cd washee_app
#flutter drive --driver=test_driver/android_driver.dart --target=integration_test/account_test.dart
flutter test integration_test
cd ..