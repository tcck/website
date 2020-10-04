VENV := ~/.venv/makesite

.PHONY: default
default: site

.PHONY: venv
venv:
	python3 -m venv $(VENV)
	echo ". $(VENV)/bin/activate" >./venv.sh
	. ./venv.sh && pip install commonmark coverage

venv.sh:
	$(MAKE) venv

.venv: venv.sh
	@touch .venv

.PHONY: site
site: .venv
	. ./venv.sh && ./vendor/makesite/makesite.py

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
test: .venv
	. ./venv.sh && python -m unittest -bv

.PHONY: coverage
coverage: .venv
	. ./venv.sh && coverage run --branch --source=. -m unittest discover -bv; :
	. ./venv.sh && coverage report -m
	. ./venv.sh && coverage html

.PHONY: vendor
vendor:
	./vendor.sh

clean:
	find . -type d -name '__pycache__' -exec rm -rf {} \;
	find . -type f -name '*.pyc' -exec rm -f {} \;
	rm -rf .coverage htmlcov _vendor
