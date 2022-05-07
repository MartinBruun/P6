# Washee Web

This README contains information of the purpose, architecture and important details of the web system.

For understanding how the web is run in development, testing, staging or production, please see the outermost README file at root.

## Purpose
The washee web functions as the backend.

## Architecture
The architecture follows a Django structure with a focus on serving the data over a REST API. This means:

Each part of the domain that handles its own subset of models is organized into different apps.
Each app have the same kind of files with the following responsibilities:
`admin.py`, handling what can be showed and manipulated on the admin interface.
`apps.py`, handling the reference to this specific app as a whole.
`models.py`, presenting all the models in the app. Also, be aware that all business logic will likewise be part of the model itself, not delegated to some other layer!
`managers.py`, presents the managers of the models. The managers handle how to access and modify singular instances of the different models, using an ORM that handles all connection to and from the SQL database.
`serializer.py`, handles all serialization and deserialization of a model to and from its corresponding json representation, being served over a REST interface.
`view_sets.py`, handles the REST interface being created.
`migrations/`, a folder having all the migration files, translating models into SQL database representations.
`tests/`, contains all tests, following the exact structure as above.

A special app, called `washee_web`, handles all outwards communication (`wsgi/asgi.py`), url management (`urls.py`) and setup of the application as a whole (`settings.py`).

## Details
Normally, a Django application also have a view layer, that presents information in a user interface. However, this has been delegated to the washee app.