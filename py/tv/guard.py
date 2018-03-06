#! /usr/bin/env python3

import os

def makeGuards(base, file, lines):
	base = os.path.abspath(base)
	file = os.path.abspath(file)
	if not file.startswith(base):
		raise ValueError('file not in base address')
	lines = list(lines)
	dir, base = os.path.split(os.path.normpath(file.replace(base, '')).lstrip('/'))
	base, ext = os.path.splitext(base)
	path = f'{dir.replace("/","_")}_{base}_{"M" if base[0].isupper() else "I"}'.upper()
	if ext == '.sv' or any(f'`ifndef {path}' in line for line in lines):
		yield from lines
		return
	yield f'`ifndef {path}\n`define {path}\n\n'
	yield from lines
	yield '\n`endif\n'

if __name__ == '__main__':
	import argparse
	import sys

	parser = argparse.ArgumentParser(
		description='Add header guards for verilog source files'
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
		lines = list(makeGuards(args.base, args.file, file))
	with args.output as file:
		file.writelines(lines)

