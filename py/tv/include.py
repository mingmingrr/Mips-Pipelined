#! /usr/bin/env python3

import re
import os

def relativizeIncludes(base, file, lines):
	base = os.path.abspath(base)
	file = os.path.abspath(file)
	if not file.startswith(base):
		raise ValueError('file not in base address')
	levels = os.path.normpath(file.replace(base, '')).count('/') - 1
	for line in lines:
		match = re.match(r'^\s*`include\s+"(.*)"\s*$', line)
		if match is not None and '../' not in match.group(1):
			yield f'`include "{"../"*levels}{match.group(1)}"\n'
		else:
			yield line

if __name__ == '__main__':
	import argparse
	import sys

	parser = argparse.ArgumentParser(
		description='Change verilog includes to be '
			'relative to base project directory'
	)
	parser.add_argument(
		'-f', '--file',
		type=os.path.abspath,
	)
	parser.add_argument(
		'-b', '--base',
		type=os.path.abspath,
		default=os.path.abspath(__file__),
	)
	parser.add_argument(
		'-i', '--input',
		type=argparse.FileType('r'),
		default=sys.stdin
	)
	parser.add_argument(
		'-o', '--output',
		type=argparse.FileType('w'),
		default=sys.stdout
	)
	args = parser.parse_args()

	with args.input as file:
		lines = list(relativizeIncludes(args.base, args.file, file))
	with args.output as file:
		file.writelines(lines)
