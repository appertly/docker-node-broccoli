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

do_build() {
    rm -rf $DIST
    broccoli build $DIST
    chown -R $OUID:$OGID $DIST
}

do_build
inotifywait -q -m -r -e close_write -e move_self -e create -e delete $SRC | while read f; do
    do_build
done
