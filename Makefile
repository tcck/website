SITE ?= ../tcck.github.io

TCCK_VENV ?= ~/.venv/tcck
VENV := $(TCCK_VENV)

.PHONY: default
default: site

venv:
	python3 -m venv $(VENV)
	echo ". $(VENV)/bin/activate" >./venv
	. ./venv && pip install -r requirements.txt

.PHONY: site
site: venv
	. ./venv && ./build.py

.PHONY: serve
serve: site
	. ./venv && (cd _site && python -m http.server -b 127.0.0.1)

.PHONY: vendor
vendor:
	@./vendor.sh

.PHONY: clean
clean:
	@rm -vrf _vendor _site

.PHONY: distclean
distclean:
	@rm -vrf ./vendor/makesite/__pycache__ venv

.PHONY: sync
sync: site
	@echo "-- SITE: $(SITE)/docs/"
	@test -e ./_site/.nojekyll || touch ./_site/.nojekyll
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
