TCCK_VENV ?= ~/.venv/tcck
VENV := $(TCCK_VENV)

.PHONY: default
default: site

venv:
	python3 -m venv $(VENV)
	echo ". $(VENV)/bin/activate" >./venv
	. ./venv && pip install commonmark coverage

.PHONY: site
site: venv
	. ./venv && ./build.py

.PHONY: serve
serve: site
	if python3 -c 'import http.server' 2> /dev/null; then \
	    echo Running Python3 http.server ...; \
	    cd _site && python3 -m http.server; \
	elif python -c 'import http.server' 2> /dev/null; then \
	    echo Running Python http.server ...; \
	    cd _site && python -m http.server; \
	elif python -c 'import SimpleHTTPServer' 2> /dev/null; then \
	    echo Running Python SimpleHTTPServer ...; \
	    cd _site && python -m SimpleHTTPServer; \
	else \
	    echo Cannot find Python http.server or SimpleHTTPServer; \
	fi

.PHONY: test
test: venv
	. ./venv && python -m unittest -bv

.PHONY: coverage
coverage: venv
	. ./venv && coverage run --branch --source=. -m unittest discover -bv; :
	. ./venv && coverage report -m
	. ./venv && coverage html

.PHONY: vendor
vendor:
	@./vendor.sh

.PHONY: clean
clean:
	@rm -vrf .coverage htmlcov _vendor

.PHONY: distclean
distclean:
	@rm -vrf ./vendor/makesite/__pycache__ venv
