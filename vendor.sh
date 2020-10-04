#!/bin/sh
TMPDIR=./_vendor
mkdir -vp ${TMPDIR}
rm -vf ${TMPDIR}/makesite.zip
wget -O ${TMPDIR}/makesite.zip \
	https://github.com/sunainapai/makesite/archive/master.zip
CWD=$(pwd)
cd ${TMPDIR}
rm -rf makesite-master
unzip -q makesite.zip
cd ${CWD}
srcd=${TMPDIR}/makesite-master
dstd=./vendor/makesite
mkdir -vp ${dstd}
install -v -m 750 ${srcd}/makesite.py ${dstd}/
install -v -m 640 ${srcd}/LICENSE.md ${dstd}/
install -v -m 640 ${srcd}/README.md ${dstd}/
install -v -m 640 ${srcd}/CONTRIBUTING.md ${dstd}/
exit 0
