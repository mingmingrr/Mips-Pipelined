$# vim: set ft=verilog:
$# name : str , parts : str (width)
`define $(name)_W \\
	($(parts))
$if(parts in {"1", 1})
`define $(name)_T(T) T
$else
`define $(name)_T(T) \\
	T [ `$(name)_W - 1 : 0 ]
$endif

