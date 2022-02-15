https://testdriven.io/blog/dockerizing-django-with-postgres-gunicorn-and-nginx/

# Building
docker-compose build
or
docker-compose up -d --build

# Starting
To start the container in the terminal
docker-compose up

To start the container as a subprocess, making it possible to run "exec" commands (see Running commands in the docker containers)
docker-compose up -d

# Shutting down
Shutting it down, persisting all changes
docker-compose down

Shutting it down, while also removing all data (called volumes) including any superuser created.
docker-compose down -v

# Running commands in the docker containers
`docker-compose exec` => 
run the docker compose file and execute a command in the web OR the db container (as seen in below commands)

`*` = `docker-compose exec`

`* web python manage.py createsuperuser` =>
Django creates a superuser (for the database and website) where you should give a username and password, which should be set in the .env.dev file.

`* web python manage.py makemigrations` =>
Django goes through the models.py files and make a migration file that maps to the database.

`* web python manage.py flush --no-input`
Django flushes the database, removing all data which is useful in development.

`* web python manage.py migrate --noinput` =>
Django applies the migrations from previous command to the databse.

`* db psql --admin` =>
The Database logs you in as the superuser admin

`CREATE DATABASE washee_web_dev OWNER admin;` =>
When logged in, this query creates the database and sets the owner  to be the Django SuperUser

`GRANT ALL ON DATABASE washee_web_dev TO admin;` =>
When logged in, grants unrestricted access to the db for the admin user.