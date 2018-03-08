$# vim: set ft=verilog:
$# name : str , parts : [(id, index)]
$py(
import math
index = 0
for i in range(len(parts)):
	if isinstance(parts[i], str):
		parts[i] = parts[i], index
		index += 1
	else:
		parts[i] = (tuple(parts[i]) + (index,))[:2]
		index = parts[i][1]
)

$for((id, index) in parts)
`define $(name)_$(id) `$(name)_W'($(index))
$endfor

`define $(name)_L $(len(parts))

$py(width = math.floor(math.log2(max(part[1] for part in parts))) + 1)
`define $(name)_W $(width)

$if(width == 1)
`define $(name)_T(T) T
$else
`define $(name)_T(T) \\
	T [`$(name)_W - 1 : 0]
$endif

