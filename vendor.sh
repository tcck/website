#!/bin/sh
mkdir -vp ./_tmp
rm -vf ./_tmp/makesite.zip
wget -O ./_tmp/makesite.zip \
	https://github.com/sunainapai/makesite/archive/master.zip
cd ./_tmp
rm -rf makesite-master
unzip -q makesite.zip
cd ..
srcd=./_tmp/makesite-master
dstd=./vendor/makesite
mkdir -vp ${dstd}
install -v -m 750 ${srcd}/makesite.py ${dstd}/
install -v -m 640 ${srcd}/LICENSE.md ${dstd}/
install -v -m 640 ${srcd}/README.md ${dstd}/
install -v -m 640 ${srcd}/CONTRIBUTING.md ${dstd}/
exit 0
