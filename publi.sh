#!/bin/sh
set -eu
REPO=${1:?'repo dir?'}
COMMIT_MSG="$(git log -1 --format='%s')"
COMMIT_INFO="$(git log -1 --format="commit %h%nAuthor: %an <%ae>%nDate:  %ad%n%nActor: ${GITHUB_ACTOR}")"
cd ${REPO}
git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
git add ./docs
if git commit -am "${COMMIT_MSG}" -m "${COMMIT_INFO}" --quiet
then
	git show --name-status
	git push origin master
fi
exit 0
