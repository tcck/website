#!/bin/sh
set -eu
REPO=${1:?'repo dir?'}
COMMIT_MSG="$(git log -1 --format='%s')"
COMMIT_INFO="$(git log -1 --format="commit %h%nAuthor: %an <%ae>%nDate:  %ad")"
cd ${REPO}
git add ./docs
if git commit -am "${COMMIT_MESSAGE}" -m "${COMMIT_DETAILS}" --quiet
then
	git show --name-status
	git push origin master
fi
exit 0
