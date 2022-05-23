cd ..
cd ..
cd washee_app
echo ------------ LINTING FOR APP --------------
call flutter analyze
echo ------------ LINTING FOR WEB --------------
call flake8 washee_web
echo ------------ LINTING FOR BOX --------------
call flake8 washee_box