def makeBitset(bitset, fields):
	output, fields, index, indexes = [], list(fields), 0, set()
	for field in fields:
		if isinstance(field, str): field = (field,)
		name, index = (tuple(field) + (index,))[:2]
		output.append(f'`define {bitset}_{name}_W 1')
		output.append(f'`define {bitset}_{name}_I {index}')
		output.append(f'`define {bitset}_{name}_T(T) T')
		output.append(f'`define {bitset}_{name}(x) \\\n\tx [ `{bitset}_{name}_I ]')
		output.append(f'`define {bitset}_{name}_V \\\n\t`{bitset}_W\'({1<<index})')
		output.append('')
		indexes.add(index)
		index += 1
	assert len(fields) == len(indexes)
	output.append(f'`define {bitset}_L {len(fields)}')
	output.append(f'`define {bitset}_W {max(indexes)}')
	output.append(f'`define {bitset}_T(T) T [`{bitset}_W-1:0]')
	return '\n'.join(output)

