# DEPLOY

Experimenting with strategies with building and deploying rails app as container image via private registry

# Environment

## Install docker-compose with Docker BuildKit support

### New
- https://docs.docker.com/compose/cli-command/#installing-compose-v2

```bash
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.4.1/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
```

### OLD
- https://www.cloudsavvyit.com/10623/how-to-install-docker-and-docker-compose-on-linux/
- https://github.com/docker/compose/releases

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/v2.4.1/docker-compose-linux-x86_64" -o /tmp/docker-compose
sudo chmod +x /tmp/docker-compose
ls -al /tmp/docker-compose
/tmp/docker-compose --version
#sudo mv /tmp/docker-compose /usr/local/bin
docker-compose --version
```


## Setup
```bash
scripts/git_clone.sh
```

## Setup development env

```bash
cp -r _demo_secrets .development_secrets
cp _env .env
cp _development_env .development_env
```

## Setup development DB

```bash
scripts/development_up.sh
docker exec -it demo_development_host bash
rake db:create
rake db:migrate
```

## Run development

```bash
scripts/development_up.sh

# http://localhost:8091/ui
```

## Build base

```bash
scripts/base_build.sh --no-cache
BASE_TAG=latest make base_tag
```

## Publish base

```bash
BASE_TAG=1.x make base_tag
BASE_TAG=1.x make base_push
```

## Setup production build env

```bash
cp _env .env
cp _build_env .build_env
```

## Build production

```bash
scripts/production_build.sh --build-arg BASE_TAG=latest --no-cache
BUILD_TAG=latest make build_tag
```

## Publish production build

```bash
BUILD_TAG=1.x make build_tag
BUILD_TAG=1.x make build_push
```

## Setup production env

```bash
cp -r _demo_secrets .production_secrets
cp _env .env
cp _production_env .production_env
```

## Setup production DB

```bash
scripts/production_up.sh
docker exec -it demo_production_host bash
rake db:create
rake db:migrate
```

## Run production

```bash
BUILD_TAG=latest make build_tag
BUILD_TAG=latest scripts/production_up.sh

# http://localhost:8092/ui
```

# References

## Docker
- https://stackoverflow.com/questions/32230577/how-do-i-define-the-name-of-image-built-with-docker-compose
- https://docs.docker.com/compose/environment-variables/
- https://faun.pub/set-current-host-user-for-docker-container-4e521cef9ffc
- https://github.com/firewalld/firewalld/issues/461
- https://docs.docker.com/network/iptables/
- https://docs.docker.com/compose/production/
- https://stackoverflow.com/questions/58592259/how-do-you-enable-buildkit-with-docker-compose
- https://docs.docker.com/develop/develop-images/build_enhancements/#new-docker-build-secret-information
- https://discourse.world/h/2020/05/12/Secure-secrets-when-building-in-Docker-Compose
- https://github.com/docker/compose/pull/7046
- https://github.com/docker/compose/pull/9386
- https://willschenk.com/articles/2020/rails_in_docker/

## Bash
- https://stackoverflow.com/questions/35385962/arrays-in-a-posix-compliant-shell

## Rails
- http://blog.siami.fr/diving-in-rails-the-request-handling
- https://coolrequest.dev/2021/12/13/docker_image_rails_part2.html
- https://stackoverflow.com/questions/3181746/what-is-the-replacement-for-actioncontrollerbase-relative-url-root
- https://apidock.com/rails/Rails/groups/class
- https://ieftimov.com/post/docker-compose-stray-pids-rails-beyond/

## Bundle

- https://stackoverflow.com/questions/35429837/docker-compose-port-mapping
- https://medium.com/magnetis-backstage/how-to-cache-bundle-install-with-docker-7bed453a5800
- https://stackoverflow.com/questions/62070585/how-to-install-new-gems-in-a-rails-docker-image-without-rebuilding-it
- https://dev.to/k_penguin_sato/cache-rails-gems-using-docker-compose-3o3f
- https://github.com/sass/sassc-ruby/issues/189
- https://dev.to/kolide/how-to-migrate-a-rails-6-app-from-sass-rails-to-cssbundling-rails-4l41

## nginx
- https://linuxhint.com/nginx-use-environment-variables/
- https://hub.docker.com/_/nginx
- https://www.digitalocean.com/community/tutorials/how-to-create-let-s-encrypt-wildcard-certificates-with-certbot
- https://stackoverflow.com/questions/29279084/nginx-proxy-add-x-forwarded-for-and-real-ip-header
