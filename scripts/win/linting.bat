cd ..
cd ..
cd washee_app
echo ------------ LINTING ERROS FOR APP --------------
call flutter analyze
echo ------------ LINTING ERRORS FOR WEB --------------
call autopep8 --in-place --recursive --aggressive washee_web
cd washee_web
call flake8
cd ..
echo ------------ LINTING ERRORS FOR BOX --------------
call autopep8 --in-place --recursive --aggressiv ewashee_box
cd washee_box
call flake8
cd ..
cd scripts
cd  win