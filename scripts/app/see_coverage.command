#!/bin/zsh

cd ..
cd ..
cd washee_app
genhtml coverage/lcov.info --output coverage/
open coverage/html/index.html