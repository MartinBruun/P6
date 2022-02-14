https://testdriven.io/blog/dockerizing-django-with-postgres-gunicorn-and-nginx/

# Building
docker-compose build
or
docker-compose up -d --build

# Starting
docker-compose up -d

# Shutting down
docker-compose down

# Running commands in the docker containers

## Migrating database schema changes
docker-compose exec web python manage.py migrate --noinput