cd ..
cd ..
call docker-compose exec -f docker-compose.web.yml web python manage.py check --deploy
echo This shows if there are any known security vulnerabilities that should be handled.
cd scripts
cd web