# P6

This is the repository used for the bachelor project for the 6. Semester Software 2022
This description should be replaced with a proper presentation, when it has been done.

CURRENTLY SETUP AS A PYTHON PROJECT BUT IS SUBJECT TO CHANGE!

## What do we want?
Give short descriptions of what we want out of the bachelor project, if any:

## Structure of the code as of now
- .github/workflows: Contains yml files which run commands on the github server (right now makes a docker continious integraiton flow)
- src: Contains source code. Right now only a main function, and a test of that main function
- gitignore: Ignores docker related files and python related files
- app.py: Contains a Flask implementation, making the docker serve as a webserver
- Dockerfile: A File installing app-get (linux standard that functions like pythons pip sort of) and installs requirements.txt + starts app.py
- Readme.md: What you are reading right now
- requirements.txt: A compilation of all libraries in this project. Right now only supports Flask and pytest.

## Project
- The P6 latex document: https://www.overleaf.com/project/61f26cc5fdacee638b780cda
- An overview of LaTeX commands: https://www.overleaf.com/project/61bb5d39bb88b12fc6058f7a

## Project board
- We use githubs Issues/Milestones/Project system
- Milestones = Releases
- Issues = User Stories and work that needs to be done
- Pull Requests = Tasks, where they have defined test names in the branch
- Pull requests are automatically put into the "Product Backlog" column of the Project Board
- The Project board has a "Sprint Backlog" column for the sprint, a "Doing" column for work being done and a "Done" column for done tasks.
- Cards are moved from the Product Backlog to the Sprint Backlog by all developers during the sprint planning meeting
- When a person is assigned a Card, the pull request is moved to the "Doing" column (Need automation!)
- When a Card passes the tests and has an accepted review, it is moved to the "Done" column (Need automation!)

## Future ideas
- Setup more action flows. Automatic labelling when pull requests or issues are created, setup deletion of stale branches, setup workflows which can be run manually, etc.
- Setup action flow, so that a reduction in coverage cannot be merged?
- Make an action that set the person initially pushing the code as the Assignee, and setting everyone else as reviewers maybe?
- Create milestones which are the Sprint Goal, and its work items?

## Setup done in the settings
- It is only possible to Squash merge. What this means is that all commits are "squashed" together into one single commit, so that one branch only fills up one commit.
- All branches can only be merged, if they are reviewed by at least one other person
- All branches can only be merged, if they pass the CI

## Maybe Useful Resources and Libraries
- Overview of cyber physical systems: https://ptolemy.berkeley.edu/projects/cps/
- Dockerfile made from this: https://docs.docker.com/language/python/build-images/
- A way to test Docker maybe: https://github.com/avast/pytest-docker
- Show automatically which lines are not covered by tests https://stackoverflow.com/questions/67482906/show-coverage-in-github-pr
- List of github actions idea https://github.com/sdras/awesome-actions
- List of actions also (discord integration) https://blog.mergify.com/the-best-github-action-you-should-use/

## Crazy ideas 
- A smell detector: recognize cinamon, rose, shit, cat piss, skimmel swamp. as a Tampen Brænder game.

- Electronic bookshelf: Tapetser din ebogreol, elektronisk papir viser ryg coveret på en bog eller en musik udgivelse, når du trykker på den vises for og bagsiden , hvis du dragger overføres den til din e reader. hook up med biblioteket og fyld din reol med alt hvad biblioteket ligger inde med. når bøger tages ud lånes de på biblioteket, hook up til spotify (her kan søges funding), hav dine foto albums, og film liggende. Det kan være et pladssparrende møbel, smukke malerier kan måske lånes på biblioteket, eller eKunst. Forskellige tapeter kan uploades.

- Build a tuner

- Automatic mini farm, expandable from simple sensor readings, to automatic harvesting

- "Smart house", a collection of integrated small utility internet of things objects for the house, connected to a website/app/rest API

- AutoFood: Optimized bread baking? Automatic Pizza Machine?

- ButlerBot: A general purpose butler robot, that can water plants indoors, bring you items and maybe boil an egg? (smart house expanded)

- CrisisApp: An app recognizing if a person feigns / shouts for help /etc. to call for the proper help.
