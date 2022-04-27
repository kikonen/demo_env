FROM ruby:2.7.5

WORKDIR /app

ARG DOCKER_USER=docker \
    DOCKER_PW=password \
    DOCKER_UID \
    DOCKER_GID

RUN test -n "$DOCKER_UID" && \
    test -n "$DOCKER_GID"

####################
# http://blog.siami.fr/diving-in-rails-the-request-handling
ENV RAILS_ENV=development \
    SCRIPT_NAME=/ui \
    RAILS_RELATIVE_URL_ROOT=/ui \
    PIDFILE=/pids/server.pid

ENV BUNDLE_PATH=/bundle/vendor \
    GEM_HOME=/bundle/vendor/ruby/2.7.0 \
    GEM_PATH=/bundle/vendor/ruby/2.7.0/bin \
    PATH=$PATH:/app/node_modules/.bin \
    PATH=$PATH:/app/bin \
    EDITOR=vim

####################
# NOTE KI CREATE dis for mounted volume permissions
RUN mkdir -p /bundle && \
    mkdir -p /app/public/assets && \
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
RUN echo "useradd -m ${DOCKER_USER} --uid=${DOCKER_UID} --gid=${DOCKER_GID}"
RUN useradd -m ${DOCKER_USER} --uid=${DOCKER_UID} --gid=${DOCKER_GID} && \
    echo "${DOCKER_USER}:${DOCKER_PW}" | chpasswd

RUN echo "docker ALL=(ALL:ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/docker

# NOTE KI Permissions WILL be applied to mounted volumes
RUN chown -R ${DOCKER_UID}:${DOCKER_GID} /bundle /app

USER ${DOCKER_UID}:${DOCKER_GID}

####################
ENTRYPOINT ["docker/docker-entrypoint.sh"]
