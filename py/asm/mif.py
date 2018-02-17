#! /usr/bin/env python3

import re

def toBin(mif):
	return (f'{int(i.strip(";").split(":")[1].strip().strip(";"), 16):0>32b}' for i in mif) # if re.match(r'^([0-9a-f]+):([0-9a-f]+);$', i.replace(' ',''))]

def fromBin(bin):
	return [f'{n:0>3x} : {int(i,2):0>8x};' for n, i in enumerate(bin)]

import sys

if sys.argv[1] == 'to':
	list(map(print, toBin(sys.stdin)))
elif sys.argv[1] == 'from':
	list(map(print, fromBin(sys.stdin)))
