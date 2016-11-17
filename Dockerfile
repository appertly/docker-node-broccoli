FROM node:7.1
MAINTAINER Jonathan Hawk <jonathan@appertly.com>

ADD package.json /tmp
ADD index.js /tmp

RUN npm install --global broccoli-cli \
    && npm install --global broccoli-timepiece \
    && cd /usr/local/lib/node_modules/broccoli-timepiece \
    && cp /tmp/package.json /usr/local/lib/node_modules/broccoli-timepiece \
    && cp /tmp/index.js /usr/local/lib/node_modules/broccoli-timepiece \
    && git config --system user.name Docker \
    && git config --system user.email docker@localhost \
    && npm install \
    && rm -rf /tmp/* /var/tmp/* \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/log/apt/* \
    && rm -rf /var/log/dpkg.log \
    && rm -rf /var/log/bootstrap.log \
    && rm -rf /var/log/alternatives.log

VOLUME ["/opt/broccoli/project"]
WORKDIR /opt/broccoli/project
ENTRYPOINT ["/usr/local/bin/broccoli-timepiece"]
CMD ["dist"]
