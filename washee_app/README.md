# Washee App

This Readme contains information of the purpose, architecture and important details of the app system.

For understanding how the app is run in development, testing, staging or production, please see the outermost Readme file at root.

## Purpose
The washee app is the system the end users will be in contact with using a user interface.

It will serve as the middle-man between any box and the backend.

## Architecture
The architechture follows a Clean Architechture principle, meaning the following:

The `lib/` folder contains 3 primary folders
`features/` which contains the features the application gives to the user. These mirror the apps presented on the backend in `washee_web`, since both describe the same subdivision of the domain.
(The difference is that "apps" subdivide with a focus on correctly presenting the models, whereas "features" subdivide with a focus on correctly presenting the behaviour.)
`core/` which contains all the shared necessary standardization, security issues and functionality. These can be Communicators defining how data storages are accessed, logging, input validation and helper functions that standardize how time is managed, etc.
`test/` which contains all the unit, widget and integration tests. The structure inside the test folder mimics the structure of the `lib/` folder.

Each feature in `features` follow this structure of 3 layers, modelled as 3 folders:
`presentation/` having the `pages/` which show the information, `widgets/` which are the building blocks used by the pages and `providers` that manage the state of the application.
`domain/` defining abstract classes representing the `entities/` of the domain, `usecases` defining the types of behaviours the system can do and abstract classes representing the `repositories/` which create the entities used by the usecases and presentation layer.
`data/` defining the implementation of the `repositories/`, using `models/` that define how to convert data from foreign `remotes/` that access endpoints outside of the app to retrieve and store data.

The callstack can be summarised as follows:
`pages/` contain `widgets/` which use `providers/` to show the applications state.
`providers/` use `usecases/` to retrieve `entities/` as given by the `repositories/` to change its state.
`repositories/` use `models/` to translate raw data given from `remotes/` into `entities/`.

In case of failures, a specific Failure exception will be thrown, which the next coming layer is expected to catch.
A provider being updated through a UseCase should always at the bare minimum catch "all exceptions" in case of anything unforseen.

The `core/` folder consists of components that are shared between the features. It is important that any extension to the core folder does not have anything to do with the domain.
- `externalities/` handles standardisation with how external storages, such as API's, are accessed. Is called by a features datasource layer.
- `standards/` handles general purpose standardisation functionality, such as time management, logging, environment setup, types of failures, etc.
- `ui/` handles non-domain specific ui to create a more cohesive app feel, including reusable widgets, navigation, theming, etc.

At root, there is a `main.dart` file that is the entrypoint to the app.
There also is an `injection_container.dart`, which creates singletons of all usecases, repositories, remotes and core functionalities, and properly dependency inject them following the architechture specified.

## Details
The architecture described is not being completely followed right now, but is expected to be able to be refactored to it.

Also, a static linting CI flow could be made to ensure that all calls to a usecase updates a provider, and these updates should at minimum catch the "everything" exception, in case of unforseen errors.

CI flows should be made such that the core standards directory is always followed (ie. never initialize a DateTime model in the features application, make sure the failures are used correctly as described above and that a Logger is called when it happens, etc.)

As an addition to the CI flow, there should be the following restrictions to secure the architecture is preserved:
Datasources may ONLY import from core
Models may ONLY import from core and other models
Repostiries may ONLY import from entities and models
Entities may NEVER import from anything (not even core!)
Usecases may ONLY import from repositories (never core!)
Providers may ONLY import from Usecases and core
Pages and Widgets may ONLY import from Providers (never core!)

The domain layer is the highest abstraction layer and should therefore never depend on anything else.
As a safety precausion, Widgets may only depend on Providers, such as to keep the UI distinctly decoupled from the business logic.
Layers can cross, ie. a BookingRepository depends on AccountRemote, BookingRemote and LocationRemote for instance.