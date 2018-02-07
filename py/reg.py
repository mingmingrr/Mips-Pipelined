"""MIPS register names"""

import csv

names, nums = {}, {}
with open('reg.tsv', 'r') as file:
	for name, num in csv.reader(file, 'excel-tab'):
		num = int(num)
		names[num] = name
		nums[name] = num

__all__ = ['names', 'nums']
