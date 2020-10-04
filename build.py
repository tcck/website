#!/usr/bin/env python

# Released for public domain. See LICENSE file.

"""Build static tcck website."""

import sys
from os import path

vendor = path.abspath(path.join('.', 'vendor', 'makesite'))
sys.path.insert(0, vendor)

import shutil
import json
import os

from datetime import datetime

import makesite as mk

def build(params, lang = ''):
	# build dir
	src = 'content'
	dst = '_site'
	if lang != '':
		src = 'content/%s' % lang
		dst = '_site/%s' % lang
	# load layouts
	page_layout = mk.fread('layout/page.html')
	# site pages
	mk.make_pages('%s/_index.md' % src, '%s/index.html' % dst,
		page_layout, **params)
	mk.make_pages('%s/[!_]*.md' % src, '%s/{{ slug }}/index.html' % dst,
		page_layout, **params)

def main():
	# build dir
	if path.isdir('_site'):
		shutil.rmtree('_site')
	# copy static files
	shutil.copytree('static', path.join('_site', 'static'))
	# configure build env
	ENV = os.getenv('TCCK_ENV', 'devel')
	mk.log("Build env: {}", ENV)
	params = {
		'base_path': '',
		'subtitle': '',
		'author': 'Editor',
		'site_url': 'http://localhost:8000',
		'current_year': datetime.now().year,
	}
	envfn = path.join('config', '%s.json' % ENV)
	params.update(json.loads(mk.fread(envfn)))
	# build site
	try:
		build(params.copy())
		build(params.copy(), lang = 'en')
	except Exception as err:
		mk.log("{}", err)
		return 2
	return 0

if __name__ == '__main__':
	sys.exit(main())
