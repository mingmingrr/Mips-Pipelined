#! /usr/bin/env python3

"""Assemble MIPS assembly into binary"""

from inst import instructions as I
import pp as P
import unify as U

def parseLine(line):
	line, inst = P.line.parseString(line, parseAll=True), None
	if line.instruction:
		inst = P.operands.parseString(I[line.opcode].args, parseAll=True)
		inst = [
			line.opcode,
			U.unify_structure(inst[0], line.operands),
			# (line, inst)
		]
	return (line.label or None, inst)

def parseProgram(lines, index=0x100000):
	insts, labels = [], {}
	for line in lines:
		label, inst = parseLine(line)
		if label is not None:
			labels[label] = index
		if inst is not None:
			insts.append(inst)
			index += 1
	return labels, insts

def toBinaryLine(labels, inst, index=0):
	# print(inst)
	opcode, operands = inst
	def encode(x):
		if '.' not in x:
			return x.replace('-', '0')
		name, width = x.split('.')
		value = operands[name]
		if type(value) is str:
			value = labels[value]
			if I[opcode].form != 'j':
				value -= index + 1
		return f'{{:0>{width}b}}'.format(value % (1 << int(width)))
	return ''.join(map(encode, I[opcode].bin))

def toBinaryProgram(lines, index=0x100000):
	labels, insts = parseProgram(lines, index=index)
	return [toBinaryLine(labels, i, n) for n, i in enumerate(insts)]

if __name__ == '__main__':
	import sys
	import argparse

	parser = argparse.ArgumentParser(
		description='Assemble MIPS assembly into machine code'
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
	parser.add_argument(
		'--index',
		dest='index',
		metavar='index',
		type=int,
		default=0x400000,
		help='starting byte index, defaults to 0x00400000'
	)

	args = parser.parse_args(sys.argv[1:])

	with args.input as input:
		prog = toBinaryProgram(input.readlines(), index=args.index//4)
	with args.output as output:
		for i in prog:
			output.write(i + '\n')
