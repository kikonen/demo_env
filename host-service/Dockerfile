FROM ruby:2.7.5

WORKDIR /app

ARG DOCKER_USER=docker \
    DOCKER_GROUP=docker \
    DOCKER_PW=password \
    DOCKER_UID \
    DOCKER_GID \
    APP_PATH

RUN test -n "$DOCKER_UID" && \
    test -n "$DOCKER_GID"

####################
# http://blog.siami.fr/diving-in-rails-the-request-handling
ENV RAILS_ENV=development \
    SCRIPT_NAME=$APP_PATH \
    RAILS_RELATIVE_URL_ROOT=$APP_PATH \
    PIDFILE=/pids/server.pid

ENV PATH=$PATH:/app/node_modules/.bin \
    PATH=$PATH:/app/bin \
    EDITOR=vim

####################
# NOTE KI CREATE dis for mounted volume permissions
RUN mkdir -p /usr/local/bundle && \
    mkdir -p /app/public/assets && \
    mkdir -p /app/node_modules && \
    mkdir -p /app/log && \
    mkdir -p /app/tmp

####################
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get update && \
    apt-get install -y --no-install-recommends nodejs && \
    apt-get install -y --no-install-recommends libcurl4-openssl-dev libpq-dev && \
    apt-get install -y --no-install-recommends postgresql-client socat sudo grep less vim

RUN npm install --global yarn

####################
RUN (grep -q -E ":${DOCKER_GID}:" /etc/group) || addgroup --gid ${DOCKER_GID} ${DOCKER_GROUP}
RUN adduser --disabled-password --gecos '' --uid ${DOCKER_UID} --gid ${DOCKER_GID} ${DOCKER_USER}

RUN echo "docker ALL=(ALL:ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/docker

# NOTE KI Permissions WILL be applied to mounted volumes
RUN chown -R ${DOCKER_UID}:${DOCKER_GID} /usr/local/bundle /app

USER ${DOCKER_UID}:${DOCKER_GID}

####################
ENTRYPOINT ["docker/docker-entrypoint.sh"]
