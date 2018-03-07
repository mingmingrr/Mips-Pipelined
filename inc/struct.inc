$# vim: set ft=verilog:
$# name : str , parts : [(id, width, index)]
$py(
for i in range(len(parts)):
	if i == 0:
		index = 0
	else:
		index = f"`{name}_{parts[i-1][0]}_W + \\\n\t`{name}_{parts[i-1][0]}_I"
	parts[i] = (tuple(parts[i]) + (index,))[:3]
)

$for((id, width, index) in parts)
`define $(name)_$(id)_W \\
	($(width))
`define $(name)_$(id)_I \\
	($(index))
$if(width in {'1', 1})
`define $(name)_$(id)_T(T) T
`define $(name)_$(id)(x) \\
	x [ `$(name)_$(id)_I ]
$else
`define $(name)_$(id)_T(T) \\
	T [ `$(name)_$(id)_W - 1 : 0 ]
`define $(name)_$(id)(x) \\
	x \\
	[ `$(name)_$(id)_I' \\
	+ `$(name)_$(id)_W - 1 \\
	: `$(name)_$(id)_I ]
$("\n")
$endif
$endfor

`define $(name)_W \\
$for((index, part) in enumerate(parts))
	$("+"if index else"(") $(part[1]) \\
$endfor
	)

`define $(name)_T(T) \\
	T [`$(name)_W - 1 : 0]

`define $(name)_Pack($(",".join(part[0] for part in parts))) \\
$for((index, part) in enumerate(reversed(parts)))
	$(","if index else"{") $(part[0]) \\
$endfor
	}

`define $(name)_Pack_Defaults \\
	`$(name)_Pack($(",".join(part[0][0].lower() + part[0][1:] for part in parts)))

`define $(name)_Decl($(",".join(part[0] for part in parts))) \\
$for((index, part) in reversed(list(enumerate(parts))))
	`$(name)_$(part[0])_T ($(part[0])) \\
		$(part[0][0].lower() + part[0][1:]); $("\\"if index else"")
$endfor

`define $(name)_Decl_Defaults \\
	`$(name)_Decl($(",".join("wire" for _ in parts)))

`define $(name)_Unpack(x,$(",".join(part[0] for part in parts))) \\
	`$(name)_Decl($(",".join(part[0] for part in parts))) \\
	assign `$(name)_Pack_Defaults = x;

`define $(name)_Unpack_Defaults(x) \\
	`$(name)_Decl(x,$(",".join("wire" for _ in parts)))

