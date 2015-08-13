#!/bin/sh
cd /opt/broccoli/project

if [ -z "${OUID}" ]
then
    OUID=$UID
fi
if [ -z "${OGID}" ]
then
    OGID=$GID
fi
SRC=${SRC_DIR:-src}
DIST=${DIST_DIR:-dist}
inotifywait -q -m -r -e modify -e create -e delete $SRC | while read f; do
    rm -rf $DIST \
        && broccoli build $DIST \
        && chown -R $OUID:$OGID $DIST
done
