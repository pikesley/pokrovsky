[![Build Status](https://travis-ci.org/pikesley/pokrovsky.png?branch=master)](https://travis-ci.org/pikesley/pokrovsky)
[![Code Climate](https://codeclimate.com/github/pikesley/pokrovsky.png)](https://codeclimate.com/github/pikesley/pokrovsky)
[![Dependency Status](https://gemnasium.com/pikesley/pokrovsky.png)](https://gemnasium.com/pikesley/pokrovsky)
[![Coverage Status](https://coveralls.io/repos/pikesley/pokrovsky/badge.png)](https://coveralls.io/r/pikesley/pokrovsky)

#Pokrovsky

##Github History Vandalism as a Service

_v0.0.1_

##Introduction

The unbroken chain of pointless Things-as-a-Service continues. This one uses my [uncle-clive](http://uncleclive.herokuapp.com) service to generate a script suitable for vandalising your Git commit history ([my account](http://github.com/pikesley) is probably displaying an example right now).

###API

####/:githublogin/:repo/:text

Will return a bash script which, when run locally, will:

* initialise a new local git repo named _:repo_
* create a series of empty commits
* push the repo to  git@github.com_:githublogin/:repo_

The commits will be structured such that they will 'write' the _:text_ on the Github commit calendar using the 1982 Sinclair Spectrum character set. There is a limitation in that the Spectrum font is 8 units high, and the Github calendar has a height of 7 (see [http://uncleclive.herokuapp.com/#textpokrovsky](http://uncleclive.herokuapp.com/#textpokrovsky)) for an explanation of how this is handled).

Create a new, disposable Github repo, then try this:

`curl http://pokrovsky.herokuapp.com/mygithubname/myrepo/1982 | bash`

###Notes

* You should start with a fresh repo each time, both locally and on Github. The script makes no attempt to create a new Github repo, and it certainly doesn't try to delete anything from there. If you can't work out how to do this safely, you probably shouldn't use this service.
* This owes a _massive_ debt to [Gelstudios'](https://github.com/gelstudios) splendid [Gitfiti](https://github.com/gelstudios/gitfiti).