@ECHO OFF

cd ..
cd ..
echo ------------ LINTING ERROS FOR APP --------------
cd washee_app
call flutter analyze
cd ..
echo ------------ LINTING ERRORS FOR WEB --------------
call autopep8 --in-place --recursive --aggressive washee_web
cd washee_web
call flake8
cd ..
echo ------------ LINTING ERRORS FOR BOX --------------
call autopep8 --in-place --recursive --aggressiv washee_box
cd washee_box
call flake8
cd ..
cd scripts
cd  win