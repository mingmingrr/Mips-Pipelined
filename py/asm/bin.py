#! /usr/bin/env python3

"""Disassemble MIPS binary to assembly"""

from inst import instructions as I
import unify as U
import functools as F

def rename(name, value, width):
	if name in ['rs', 'rt', 'rd']:
		return f'${int(value, 2)}'
	if name in ['imm', 'offset']:
		if value[0] == '1':
			return str(int(value, 2) - (1 << width))
		else:
			return str(int(value, 2))
	if name in ['target']:
		return hex(int(value, 2))
	return str(int(value, 2))

def parseBin(binary, naming=rename):
	names = None
	for _, inst in I.items():
		names = U.unify_binary(binary, inst.bin)
		if names is not None:
			break
	if names is None:
		raise ValueError('no unifying instruction')
	names = {k:rename(k, *v) for k, v in names.items()}
	return inst.name + ' ' + F.reduce(
		lambda s, x: s.replace(*map(str, x)),
		names.items(), inst.args
	)

if __name__ == '__main__':
	import sys
	import argparse

	parser = argparse.ArgumentParser(
		description='Disassemble MIPS machine code into assembly'
	)
	parser.add_argument(
		'-i',
		dest='input',
		metavar='input',
		type=argparse.FileType('r'),
		default=sys.stdin,
		help='input file, if unspecified read from stdin'
	)
	parser.add_argument(
		'-o',
		dest='output',
		metavar='output',
		type=argparse.FileType('w'),
		default=sys.stdout,
		help='output file, if unspecified write to stdout'
	)

	args = parser.parse_args(sys.argv[1:])

	with args.input as input:
		prog = input.readlines()
	prog = list(map(parseBin, prog))
	with args.output as output:
		for i in prog:
			output.write(i + '\n')

