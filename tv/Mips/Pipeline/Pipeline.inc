$# vim: set ft=verilog:
$(tv.makeStruct(name+"_Pipeline",
	[(part, "`"+type+"_W") for part, type in parts]))

module $(name)_pack
	( `$(name)_Pipeline_T (output) pipe
$for((part, type) in parts)
	, `$(type)_T (input) $(part[0].lower() + part[1:])
$endfor
	);
assign pipe = `$(name)_Pipeline_Pack_Defaults;
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
	, `$(name)_Pipeline_T (output) pipe
	);

$for((part, type) in parts)
`$(type)_T (wire) $(part[0].lower() + part[1:])\$;
Util_Delay_array #
	( .WIDTH (`$(type)_W)
	, .DELAY (DELAYED ? $(part.upper())_DELAY : 0)
	, .RESET ($(part.upper())_RESET)
	) $(part.upper())DELAY
	( .ctrl (ctrl)
	, .in  ($(part[0].lower() + part[1:]))
	, .out ($(part[0].lower() + part[1:])\$)
	);
$endfor

$(name)_pack
	( .pipe (pipe)
$for((part, type) in parts)
	, .$(part[0].lower() + part[1:]) ($(part[0].lower() + part[1:])\$)
$endfor
	);

endmodule

module $(name)_unpack
	( `$(name)_Pipeline_T (input) pipe
$for((part, type) in parts)
	, `$(type)_T (output) $(part[0].lower() + part[1:])
$endfor
	);
assign `$(name)_Pipeline_Pack_Defaults = pipe;
endmodule

