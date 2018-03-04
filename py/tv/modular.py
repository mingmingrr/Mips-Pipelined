#! /usr/bin/env python3

import os

def relativizeIncludes(base, file, lines):
	base = os.path.abspath(base)
	file = os.path.abspath(file)
	if not file.startswith(base):
		raise ValueError('file not in base address')
	dir, base = os.path.split(os.path.normpath(file.replace(base, '')).lstrip('/'))
	base, ext = os.path.splitext(base)
	return f'{dir.replace("/","_")}_{base}{ext}'

if __name__ == '__main__':
	import argparse
	import sys

	parser = argparse.ArgumentParser(
		description='Rename verilog files to their top level names'
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

	with open(args.file, 'r') as file:
		lines = list(relativizeIncludes(args.base, args.file, file))
	if args.out == os.path.abspath('--'):
		print(*lines, sep='')
	else:
		with open(args.out, 'w') as file:
			file.writelines(lines)

