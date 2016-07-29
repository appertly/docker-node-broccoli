FROM node:0.10
MAINTAINER Jonathan Hawk <jonathan@appertly.com>

RUN npm install --global broccoli-cli \
    && npm install --global broccoli-timepiece \
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
