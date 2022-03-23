cd ..
cd ..
call docker-compose -f docker-compose.web.yml up -d --build
call docker-compose -f docker-compose.web.yml exec web python manage.py migrate --noinput
call docker-compose -f docker-compose.web.yml exec web python manage.py collectstatic --no-input
cd scripts
cd web
echo THIS SHOULD BE LINUX INSTEAD FOR PROPER PRODUCTION!