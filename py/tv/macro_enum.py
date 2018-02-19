import math

def makeEnum(enum, fields):
	output, fields, index, indexes = [], list(fields), 0, set()
	for field in fields:
		if isinstance(field, str): field = (field,)
		name, index = (tuple(field) + (index,))[:2]
		output.append(f'`define {enum}_{name} `{enum}_W\'({index})')
		indexes.add(index)
		index += 1
	assert len(indexes) == len(fields)
	output.append('')
	output.append(f'`define {enum}_L {len(fields)}')
	width = math.floor(math.log2(max(indexes))) + 1
	output.append(f'`define {enum}_W {width}')
	if width == 1:
		output.append(f'`define {enum}_T(T) T')
	else:
		output.append(f'`define {enum}_T(T) \\\n\tT [`{enum}_W-1:0]')
	return '\n'.join(output)

if __name__ == '__main__':
	struct, *fields = sys.stdin.readlines()
	print(makeStruct(
		struct.strip(),
		(i.strip().split(' ') for i in fields)
	))
