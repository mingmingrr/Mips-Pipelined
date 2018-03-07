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
`define $(enum)_$(id) `$(enum)_W\'($(index))
$endfor

`define $(enum)_L $(len(parts))

$py(width = math.floor(math.log2(max(indexes))) + 1)
`define $(enum)_W $(width)

$if(width == 1)
`define $(enum)_T(T) T
$else
`define $(enum)_T(T) \
	T [`$(enum)_W - 1 : 0]
$endif

