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
		'-o', '--out',
		type=os.path.abspath,
		default='--'
	)
	args = parser.parse_args()

	with open(args.file, 'r') as file:
		lines = list(relativizeIncludes(args.base, args.file, file))
	if args.out == os.path.abspath('--'):
		print(*lines, sep='')
	else:
		with open(args.out, 'w') as file:
			file.writelines(lines)
