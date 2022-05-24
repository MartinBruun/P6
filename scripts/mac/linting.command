#!/bin/zsh

cd ..
cd ..
echo -------------------- INFO -----------------------
echo This automatically lints everything.
echo It should take 15 seconds at max to lint it all.
echo ------------ LINTING ERROS FOR APP --------------
cd washee_app
flutter analyze
cd ..
echo ------------ LINTING ERRORS FOR WEB --------------
autopep8 --in-place --recursive --aggressive washee_web
cd washee_web
flake8
cd ..
echo ------------ LINTING ERRORS FOR BOX --------------
autopep8 --in-place --recursive --aggressiv washee_box
cd washee_box
flake8
cd ..
cd scripts
cd mac