"""MIPS instructions"""

import csv
import os
from collections import namedtuple

Instruction = namedtuple('Instruction', 'name form args bin')

instructions = dict()
with open(os.path.join(os.path.dirname(__file__), 'inst.tsv'), 'r') as file:
	for (inst, form, args, *code) in csv.reader(file, 'excel-tab'):
		instructions[inst] = Instruction(
			name = inst,
			form = form,
			args = args,
			bin  = code,
		)

__all__ = ['instructions']
