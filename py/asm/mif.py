#! /usr/bin/env python3

import re

def toBin(mif):
	for i in mif:
		# if re.match(r'^([0-9a-f]+):([0-9a-f]+);$', i.replace(' ',''))]
		yield f'{int(i.strip(";").split(":")[1].strip().strip(";"), 16):0>32b}'

def fromBin(bin):
	yield 'WIDTH=32; DEPTH=64; ADDRESS_RADIX=HEX; DATA_RADIX=HEX; CONTENT BEGIN'
	for n, i in enumerate(bin):
		yield f'{n:0>3x} : {int(i,2):0>8x};'
	yield 'END;'

import sys

if sys.argv[1] == 'to':
	list(map(print, toBin(sys.stdin)))
elif sys.argv[1] == 'from':
	list(map(print, fromBin(sys.stdin)))
