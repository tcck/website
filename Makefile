SITE ?= ../tcck.github.io

.PHONY: default
default: site

.PHONY: site
site:
	./build.mks

.PHONY: serve
serve: site
	@mks -serve ./_site

.PHONY: clean
clean:
	@rm -vrf _site

.PHONY: sync
sync: site
	@echo "-- SITE: $(SITE)/docs/"
	@touch ./_site/.nojekyll
	@rsync -vax --delete-before ./_site/ $(SITE)/docs/

GITHUB_ACTOR ?= 'NOGHACTOR'
PUBLISH_TOKEN ?= 'NOPUBLISHTOKEN'

.PHONY: clone-publish-repo
clone-publish-repo:
	@rm -vrf $(SITE)
	git clone --single-branch --branch master --depth 1 \
		https://$(GITHUB_ACTOR):$(PUBLISH_TOKEN)@github.com/tcck/tcck.github.io.git $(SITE)

.PHONY: publish
publish:
	./publi.sh $(SITE)
