FROM node:0.10
MAINTAINER Jonathan Hawk <jonathan@appertly.com>

RUN npm install --global broccoli-cli \
    && npm install --global broccoli-timepiece \
    && cd /usr/local/lib/node_modules/broccoli-timepiece \
    && wget -O package.json https://raw.githubusercontent.com/kroofy/broccoli-timepiece/bd3d80afeef915d1388bfd95b6de227ce61b94dc/package.json \
    && wget -O index.js https://raw.githubusercontent.com/kroofy/broccoli-timepiece/bd3d80afeef915d1388bfd95b6de227ce61b94dc/index.js \
    && npm install broccoli-sane-watcher \
    && npm update \
    && rm -rf /tmp/* /var/tmp/* \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/log/apt/* \
    && rm -rf /var/log/dpkg.log \
    && rm -rf /var/log/bootstrap.log \
    && rm -rf /var/log/alternatives.log \

VOLUME ["/opt/broccoli/project"]
WORKDIR /opt/broccoli/project
ENTRYPOINT ["/usr/local/bin/broccoli-timepiece"]
CMD ["dist"]
