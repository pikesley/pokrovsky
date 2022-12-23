# Pokrovsky

_Github History Vandalism as a Service_

## Introduction

The unbroken chain of pointless Things-as-a-Service continues. This one uses my [Uncle Clive](//github.com/pikesley/uncle-clive) tool (via my [Dead Cockroach](//github.com/pikesley/dead-cockroach) tool) to generate a script suitable for vandalising your Git commit history ([my account](//github.com/pikesley) is probably displaying an example right now).

### API

#### `/:githublogin/:repo/:text`

Will return a bash script which, when run locally, will:

* initialise a local git repo named _:repo_
* create a series of empty commits
* push the repo to **git@github.com:_:githublogin/:repo_.git**

The commits will be structured such that they will 'write' the **first six characters** of _:text_ on the Github commit calendar using the 1982 Sinclair Spectrum character set. There is a limitation in that the Spectrum font is 8 units high, and the Github calendar has a height of 7 (see [dead-cockroach](//github.com/pikesley/dead-cockroach/blob/master/README.md) for an explanation of how this is handled).

All of the above assumes that you can do public-key authentication to Github from the box on which you're running this.

## Running it

This *used* to all run on the Heroku free-tier, but they stopped that party in November 2022, so I've now revived it with an over-elaborate `docker-compose` setup. You need to check out three different repos, so find somewhere on your laptop where you wanna put it all, then:

```
for REPO in uncle-clive dead-cockroach pokrovsky ;
do
    git clone https://github.com/pikesley/${REPO}
done
```

Then get the `docker-compose` files:

```
curl https://gist.githubusercontent.com/pikesley/012bb61d88cf1668dbcc85f8818c0849/raw/6f21fbe98b3f1f111fc4b08de757e644d1477f2a/docker-compose.yml -o docker-compose.yml
curl https://gist.githubusercontent.com/pikesley/012bb61d88cf1668dbcc85f8818c0849/raw/6f21fbe98b3f1f111fc4b08de757e644d1477f2a/.env -o .env
```

And build and run it:

```
docker compose build
docker compose up
```

### Using it

To actually vandalise your GH commit graph, from a different terminal,

```
export DISPOSABLEREPO=dummy
export GRAFFITI=`echo "© 1982" | sed "s: :%20:g"`
export  GITHUBUSER=yourghuser
curl "http://localhost:8080/${GITHUBUSER}/${DISPOSABLEREPO}/${GRAFFITI}" | bash
```

(Note: there's some latency before the commits actually appear in you graph, be patient)

### Notes

* This is *ancient* Ruby and I have no interest in updating it. Many of the tests are now busted and I really don't care.
* You should start with a fresh repo each time, both locally and on Github. The script makes no attempt to create a new Github repo, and it certainly doesn't try to delete anything from there. If you can't work out how to do this safely, you probably shouldn't use this service.
* If you decide this isn't for you after all, just delete the repo and it will all go away.
* This owes a _massive_ debt to [Gelstudios'](//github.com/gelstudios) splendid [Gitfiti](//github.com/gelstudios/gitfiti).
* I gave a talk about this at [EMF Camp 2014](//sam.pikesley.org/talks/#vandalising-your-github-commit-history-emf-2014).
