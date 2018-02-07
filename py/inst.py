"""MIPS instructions"""

import csv
from collections import namedtuple

Instruction = namedtuple('Instruction', 'name form args bin')

instructions = dict()
with open('inst.tsv', 'r') as file:
	for (inst, form, args, *code) in csv.reader(file, 'excel-tab'):
		instructions[inst] = Instruction(
			name = inst,
			form = form,
			args = args,
			bin  = code,
		)

__all__ = ['instructions']
