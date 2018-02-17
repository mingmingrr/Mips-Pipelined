#! /usr/bin/env python3

import sys

def makeStruct(struct, fields):
	output, fields, last = [], list(fields), None
	for name, width in fields:
		output.append(f'`define {struct}_{name}_W {width}')
		if last is None:
			output.append(f'`define {struct}_{name}_I 0')
		else:
			output.append(f'`define {struct}_{name}_I \\\n\t' 
				+ f'`{struct}_{last}_W + \\\n\t`{struct}_{last}_I')
		last = name
		if width in {'1', 1}:
			output.append(f'`define {struct}_{name}_T(T) T')
			output.append(f'`define {struct}_{name}(x) \\\n\tx [ `{struct}_{name}_I ]')
		else:
			output.append(f'`define {struct}_{name}_T(T) \\\n\tT [ `{struct}_{name}_W - 1 : 0 ]')
			output.append(' \\\n\t'.join([
				f'`define {struct}_{name}(x)', 'x', f'[ `{struct}_{name}_I',
				 f'+ `{struct}_{name}_W - 1', f':`{struct}_{name}_I ]']))
		output.append('')
	output.append(f'`define {struct}_W \\\n\t'
		+ ' + \\\n\t'.join(map(str, (i[1] for i in fields))))
	output.append(f'`define {struct}_T(T) T [`{struct}_W-1:0]')
	output.append(f'`define {struct}_Init(' + ', '.join(i[0] for i in fields) + ') { \\\n\t'
		+ ', \\\n\t'.join(f'`{struct}_{i[0]}_W\'({i[0]})' for i in fields)
		+ ' \\')
	output.append('\t}')
	output.append(f'`define {struct}_Init_Defaults \\\n\t`{struct}_Init('
		+ ', '.join(i[0][0].lower() + i[0][1:] for i in fields) + ')')
	return '\n'.join(output)

if __name__ == '__main__':
	struct, *fields = sys.stdin.readlines()
	print(makeStruct(
		struct.strip(),
		(i.strip().split(' ') for i in fields)
	))
