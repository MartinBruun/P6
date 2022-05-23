cd ..
cd ..
cd washee_app
echo ------------ LINTING FOR APP --------------
call flutter analyze
echo ------------ LINTING FOR WEB --------------
echo AUTOFIX THE EASIEST WITH BLACK
echo MAKE SURE IT FOLLOWS tox.ini!
call flake8 washee_web
echo ------------ LINTING FOR BOX --------------
echo AUTOFIX THE EASIEST WITH BLACK
echo MAKE SURE IT FOLLOWS tox.ini!
call flake8 washee_box