#! /usr/bin/env python3

import re
import os
import sys

path1 = os.path.abspath(sys.argv[1])
path2 = os.path.abspath(sys.argv[2])
levels = path2.replace(path1, '').count('/') - 1

lines = []
with open(sys.argv[2], 'r') as file:
	for line in file:
		lines.append(
			re.sub(
				r'^(`include\s+")(.*")$',
				r'\1' + '../' * levels + r'\2',
				line,
			)
		)

with open(sys.argv[2], 'w') as file:
	file.writelines(lines)
