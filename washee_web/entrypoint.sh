#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $DB_HOST $DB_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

python manage.py flush --no-input
python manage.py makemigrations
python manage.py migrate
python manage.py loaddata init_priorgade_users.json
python manage.py loaddata init_priorgade_accounts.json
python manage.py loaddata init_priorgade_models.json
python manage.py loaddata init_priorgade_services.json
python manage.py loaddata init_priorgade_locations.json
python manage.py loaddata init_priorgade_machines.json
python manage.py loaddata init_priorgade_bookings.json

exec "$@"
