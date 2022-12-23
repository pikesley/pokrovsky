PROJECT = $(shell basename $(shell pwd))
ID = pikesley/${PROJECT}

build:
	docker build \
		--tag ${ID} .

run:
	docker run \
		--name ${PROJECT} \
		--hostname ${PROJECT} \
		--volume $(shell pwd):/opt/${PROJECT} \
		--interactive \
		--publish 8080:8080 \
		--tty \
		--rm \
		${ID} \
		bash
