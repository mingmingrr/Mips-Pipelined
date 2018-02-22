"""MIPS register names"""

import csv
import os

names, nums = {}, {}
with open(os.path.join(os.path.dirname(__file__), 'reg.tsv'), 'r') as file:
	for name, num in csv.reader(file, 'excel-tab'):
		num = int(num)
		names[num] = name
		nums[name] = num

__all__ = ['names', 'nums']
