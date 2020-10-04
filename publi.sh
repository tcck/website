#!/bin/sh
set -eu
REPO=${1:?'repo dir?'}
COMMIT_MSG="$(git log -1 --format='%s')"
COMMIT_INFO="$(git log -1 --format="commit %h%nAuthor: %an <%ae>%nDate:  %ad%n%nActor: ${GITHUB_ACTOR}")"
git clone --single-branch --branch master --depth 1 \
	https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/tcck/tcck.github.io.git
cd ${REPO}
git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
git add ./docs
if git commit -am "${COMMIT_MSG}" -m "${COMMIT_INFO}" --quiet
then
	echo "machine github.com" >~/.netrc
	echo "login ${GITHUB_ACTOR}" >>~/.netrc
	echo "password ${GITHUB_TOKEN}" >>~/.netrc
	echo "machine api.github.com" >>~/.netrc
	echo "login ${GITHUB_ACTOR}" >>~/.netrc
	echo "password ${GITHUB_TOKEN}" >>~/.netrc
	git show --name-status
	git push origin master
fi
exit 0
