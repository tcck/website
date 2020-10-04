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

def main():
	ENV = os.getenv('TCCK_ENV', 'devel')
	mk.log("Build env: {}", ENV)
	if path.isdir('_site'):
		shutil.rmtree('_site')
	shutil.copytree('static', path.join('_site', 'static'))

	params = {
		'base_path': '',
		'subtitle': '',
		'author': 'Editor',
		'site_url': 'http://localhost:8000',
		'current_year': datetime.now().year,
	}
	try:
		envfn = path.join('config', '%s.json' % ENV)
		params.update(json.loads(mk.fread(envfn)))
	except Exception as err:
		mk.log("{}", err)
		return 2

	return 0

if __name__ == '__main__':
	sys.exit(main())
