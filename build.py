#!/usr/bin/env python

# Released for public domain. See LICENSE file.

"""Build static tcck website."""

import sys
from os import path

vendor = path.abspath("./vendor/makesite")
sys.path.insert(0, vendor)

import makesite as mk

def main():
	mk.main()
	return 0

if __name__ == '__main__':
	sys.exit(main())
