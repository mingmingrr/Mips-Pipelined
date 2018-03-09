$# vim: set ft=verilog:
$# name : str, parts : [(id : str, type : str)]
$begin
$py(name, parts = name, [(id, "`"+type+"_W") for (id, type) in parts])
$include("inc/struct.inc")
$end

module $(name)_pack
	( `$(name)_T (output) pipe
$for((part, type) in parts)
	, `$(type)_T (input) $(part[0].lower() + part[1:])
$endfor
	);
assign pipe = `$(name)_Pack_Defaults;
endmodule

`include "Util/Delay/array.v"
`include "Data/Control/Control.v"

module $(name)_generate #
	( parameter DELAYED = 1
$for((part, type) in parts)
	, parameter $(part.upper())_DELAY = 0
	, parameter $(part.upper())_RESET = `$(type)_W'(0)
$endfor
	)
	( `Data_Control_Control_T (input) ctrl
$for((part, type) in parts)
	, `$(type)_T (input) $(part[0].lower() + part[1:])
$endfor
	, `$(name)_T (output) pipe
	);

$for((part, type) in parts)
`$(type)_T (wire) $(part[0].lower() + part[1:])\$;
Util_Delay_array #
	( .WIDTH (`$(type)_W)
	, .DELAY (DELAYED ? $(part.upper())_DELAY : 0)
	, .RESET ($(part.upper())_RESET)
	) DELAY$(part.upper())
	( .ctrl (ctrl)
	, .in  ($(part[0].lower() + part[1:]))
	, .out ($(part[0].lower() + part[1:])\$)
	);
$endfor

$(name)_pack PIPEPACK
	( .pipe (pipe)
$for((part, type) in parts)
	, .$(part[0].lower() + part[1:]) ($(part[0].lower() + part[1:])\$)
$endfor
	);

endmodule

module $(name)_unpack
	( `$(name)_T (input) pipe
$for((part, type) in parts)
	, `$(type)_T (output) $(part[0].lower() + part[1:])
$endfor
	);
assign `$(name)_Pack_Defaults = pipe;
endmodule

