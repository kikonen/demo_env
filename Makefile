build: build_host
tag: tag_host
push: push_host

build_host:
	docker-compose --project-name demo_build -f docker-compose.yml -f docker-compose.build.yml build --no-cache host

tag_host:
	docker image tag demo_build_host docker.ikari.fi/demo_build_host:${BUILD_TAG}

push_host:
	docker image push docker.ikari.fi/demo_build_host:${BUILD_TAG}
