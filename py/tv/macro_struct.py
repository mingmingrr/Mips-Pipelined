def makeStruct(struct, fields):
	output, fields, index = [], list(fields), 0
	for field in fields:
		name, width, index = (tuple(field) + (index,))[:3]
		output.append(f'`define {struct}_{name}_W ({width})')
		output.append(f'`define {struct}_{name}_I \\\n\t({index})')
		index = f'`{struct}_{name}_W + \\\n\t`{struct}_{name}_I'
		if width in {'1', 1}:
			output.append(f'`define {struct}_{name}_T(T) T')
			output.append(f'`define {struct}_{name}(x) \\\n\tx [ `{struct}_{name}_I ]')
		else:
			output.append(f'`define {struct}_{name}_T(T) \\\n\tT [ `{struct}_{name}_W - 1 : 0 ]')
			output.append(' \\\n\t'.join([
				f'`define {struct}_{name}(x)', 'x', f'[ `{struct}_{name}_I',
				 f'+ `{struct}_{name}_W - 1', f':`{struct}_{name}_I ]']))
		output.append('')
	output.append(f'`define {struct}_W (\\\n\t'
		+ ' + \\\n\t'.join(map(str, (i[1] for i in fields))) + ')')
	output.append(f'`define {struct}_T(T) T [`{struct}_W-1:0]')
	output.append(f'`define {struct}_Pack(' + ', '.join(i[0] for i in fields) + ') { \\\n\t'
		+ ', \\\n\t'.join(f'{i[0]}' for i in reversed(fields)) # `{struct}_{i[0]}_W\'
		+ ' \\\n\t}')
	output.append(f'`define {struct}_Pack_Defaults \\\n\t`{struct}_Pack('
		+ ', '.join(i[0][0].lower() + i[0][1:] for i in fields) + ')')
	output.append(f'`define {struct}_Decl \\\n\t'
		+ ' \\\n\t'.join(f'`{struct}_{i[0]}_T(wire) {i[0][0].lower() + i[0][1:]};'
			for i in fields))
	output.append(f'`define {struct}_Unpack(x) \\\n\t`{struct}_Decl \\\n\t'
		+ f'assign `{struct}_Pack_Defaults = x ;')
	return '\n'.join(output)

