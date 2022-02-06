build: build_host
build_tag: tag_host
build_push: push_host

base_tag: tag_host_base
base_push: push_host_base

build_host:
	docker-compose --project-name demo_build -f docker-compose.yml -f docker-compose.build.yml build --no-cache host


tag_host:
	docker image tag demo_build_host docker.ikari.fi/demo_build_host:${BUILD_TAG}

push_host:
	docker image push docker.ikari.fi/demo_build_host:${BUILD_TAG}

tag_host_base:
	docker image tag demo_base_host docker.ikari.fi/demo_base_host:${BASE_TAG}

push_host_base:
	docker image push docker.ikari.fi/demo_base_host:${BASE_TAG}
