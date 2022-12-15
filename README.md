# The Tile Farm
This is the code for an online, economic endowment experiment, the results of which were first published in chater 3, section 4 of Bower-Bir's (2014) _[What We Deserve: The Moral Origins of Economic Inequality and Our Policy Responses to It](https://pqdtopen.proquest.com/doc/1628095801.html?FMT=ABS "Bower-Bir (2014)")_.


## How to cite this program

If you use this code in your research, or if you based your experiment on this code, please cite it using the following information (alter the style to fit your journal's or discipline's guidelines):

* Bower-Bir, Jacob S., Benjamin J. Calvin, and Timothy Downey. 2013. The Tile Farm: A Simulated-multiplayer Endowment Experiment with Voluntary Redistribution Mechanism. [Computer software]. Retrieved from <https://github.com/jbowerbir/JacobsFarm>.

Please also cite the paper in which this experiment was introduced:

* Bower-Bir, Jacob S. 2014. _What We Deserve: The Moral Origins of Economic Inequality and Our Policy Responses to It._ PhD dissertation. Indiana University, Bloomington.


## Notes on the contents of this repository

You'll find four folders in this repository:

* `assets` -- this folder contains images and the like used in the game
* `config` -- this folder contains the XML files for the various questions, instructions, demographics quiz, disclaimers, etc.
* `web` -- this folder has a couple of index.html files (NOTE: we're in the process of determining which is the appropriate one to keep) that were used to house the Flash applet and a PHP script that collected the responses and put them into the database
* `src` -- this folder contains the actionscript files

Additional notes worth, er, noting:
* Usernames and passwords in the web/submissions.php script (this was originally named datatest2.php) have been deleted.
* Server information from the submissions portion of the ActionScript code have replaced with a dummy example.com url.
* We programmed this experiment in 2013, and we designed it to be run on contemporary and legacy browers to ensure as robust a sample as possible. Most browsers that people actually use these days don't come with Flash installed, or they actively prevent users from installing it since Flash isn't supported anymore and is largely insecure. Current users will likely want to rework our code in Javascript and use JSON instead of a bunch of XML files.
* These files contain what we believe to be the essential elements needed for re-running or tweaking our experimental game. Essential to a viable experiment, however, is a solid recruiting and sampling a procedure. Please see Bower-Bir (2014) cited above for details on our sampling procedure. And please let us know if any of the included files seem out of place or don't appear to do what they're supposed to. We'll look through our original files and make necessary ammendments to this repository.

Please contact jbowerbir@gmail.com with any questions or comments.
