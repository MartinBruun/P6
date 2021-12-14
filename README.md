# P6

This is the repository used for the bachelor project for the 6. Semester Software 2022
This description should be replaced with a proper presentation, when it has been done.

CURRENTLY SETUP AS A PYTHON PROJECT BUT IS SUBJECT TO CHANGE!

## What do we want?
- Give short descriptions of what we want out of the bachelor project, if any:
Martin:
- I would like to try to be the product owner
- I want that the product is cyber-physical. It should not be an app with a "fun" cyber-physical thing on top.
- 
Jakob:
- 
Rasmus:
- 

## Project board
- Use githubs own project overview instead of trello perhaps? An example of it can be found in "Projects" at the top
- Right now has implemented the "Sprint Backlog -> Test Branch created -> Implementing -> Done" workflow
- Can be automated to be moved to done, after a successfull review have accepted the implementation + other stuff.
- The features in a product backlog could be issues, managed in Releases (Milestones). Tasks would then be Pull Requests. (just an idea, don't know if its a good idea though)
- We would still need some form of user story board to get a better overview though. But the details should be on github.

# Wiki
- - Use githubs wiki when we make problem analysis and want to document difficult parts of the code? Can serve as an appendix like in aSTEP.? Or maybe we can copy-paste parts of the wiki into the project, such as theory / problem analysis / etc. ? An example of it can be found in "Wiki" at the top 

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

## Crazy ideas 
- A smell detector: recognize cinamon, rose, shit, cat piss, skimmel swamp. as a Tampen Brænder game.

- Electronic bookshelf: Tapetser din ebogreol, elektronisk papir viser ryg coveret på en bog eller en musik udgivelse, når du trykker på den vises for og bagsiden , hvis du dragger overføres den til din e reader. hook up med biblioteket og fyld din reol med alt hvad biblioteket ligger inde med. når bøger tages ud lånes de på biblioteket, hook up til spotify (her kan søges funding), hav dine foto albums, og film liggende. Det kan være et pladssparrende møbel, smukke malerier kan måske lånes på biblioteket, eller eKunst. Forskellige tapeter kan uploades.

- Build a tuner

- Automatic mini farm, expandable from simple sensor readings, to automatic harvesting

- "Smart house", a collection of integrated small utility internet of things objects for the house, connected to a website/app/rest API

- AutoFood: Optimized bread baking? Automatic Pizza Machine?

- ButlerBot: A general purpose butler robot, that can water plants indoors, bring you items and maybe boil an egg? (smart house expanded)

- CrisisApp: An app recognizing if a person feigns / shouts for help /etc. to call for the proper help.