DOCKER_REPO = mgar/docker-php-fpm-build
VERSION ?= $(shell ls -rd */ | cut -f1 -d'/' | head -1)


.PHONY: build clean run

build:
	-docker images | grep $(DOCKER_REPO) | grep $(VERSION) > /dev/null 2>&1 && docker rmi $(DOCKER_REPO):$(VERSION)
	docker build --no-cache --force-rm -t $(DOCKER_REPO):$(VERSION) $(VERSION)

clean:
	docker rmi $(DOCKER_REPO):$(VERSION)

enter:
	docker run -P -ti $(DOCKER_REPO):$(VERSION) /bin/bash
