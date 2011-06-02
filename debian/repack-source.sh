#!/bin/sh

set -e

if [ $# -ne 3 ]
then
    echo "Usage: $0 option version filename"
    echo "If option=--upstream-version, run uupdate after repacking sources."
    exit
fi

VERSION=$2
FILENAME=$3
DEBVERSION="${VERSION}+dfsg"

TMPDIR=`mktemp -d omegat-tmpXXXX`
BASEDIR="$TMPDIR/omegat-${VERSION}+dfsg"
mkdir "$BASEDIR"
unzip -d "$BASEDIR" "$FILENAME"

# Remove third-party libraries
rm -r "${BASEDIR}/lib"
rm "${BASEDIR}/nbproject/org-netbeans-modules-java-j2seproject-copylibstask.jar"
rm -r "${BASEDIR}/test/lib"
rm -r "${BASEDIR}/gen/lib"

# Remove win32 executables
rm ${BASEDIR}/release/win32-specific/*exe

# Remove hunspell libraries
rm -r "${BASEDIR}/native"

# Repack
GZIP=-9 tar -C "$TMPDIR" -czf "../omegat_${DEBVERSION}.orig.tar.gz" "omegat-${DEBVERSION}"

# Clean temporary files
rm -rf "$TMPDIR"
rm -rf "${BASEDIR}"
rm -f "$FILENAME"

if [ $1 = --upstream-version ] ;
then
    uupdate --upstream-version "${DEBVERSION" "omegat_${DEBVERSION}.orig.tar.gz"
fi
