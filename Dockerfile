FROM node:0.10
MAINTAINER Jonathan Hawk <jonathan@appertly.com>

WORKDIR /opt/broccoli

ADD package.json /opt/broccoli/package.json

RUN apt-get update \
    && apt-get install -y inotify-tools \
    && rm -rf /var/lib/apt/lists/* \
    && npm install --global broccoli-cli \
    && mkdir src \
    && mkdir dist \
    && npm install --save broccoli \
    && npm install --save broccoli-babel-transpiler \
    && npm install --save broccoli-funnel \
    && npm install --save broccoli-concat \
    && npm install --save broccoli-merge-trees \
    && npm dedupe

ENV SRC_DIR src
ENV DIST_DIR dist

VOLUME ["/opt/broccoli/project"]
ADD start.sh /scripts/start.sh
RUN chmod +x /scripts/start.sh
CMD ["/scripts/start.sh"]
