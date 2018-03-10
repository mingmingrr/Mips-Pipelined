$# vim: set ft=verilog:
$# name : str, parts : [(id : str, type : str, delay : bool)]
$py(parts = [(
	part[0],
	part[1],
	int(part[2]) if len(part) > 2 else 0
) for part in parts])

$begin
$py(parts = [(id, f"`{type}_W") for (id, type, delay) in parts])
$include("inc/struct.inc")
$end

`include "Util/Delay/array.v"
`include "Data/Control/Control.v"

module $(name)_generate #
	( parameter DELAYED = 1
$for((id, type, delay) in parts)
	, parameter $(id.upper())_DELAY = $(delay)
$endfor
$for((id, type, delay) in parts)
	, parameter $(id.upper())_RESET = `$(type)_W'(0)
$endfor
	)
	( `Data_Control_Control_T (input) ctrl
$for((id, type, delay) in parts)
	, `$(type)_T (input) $(id[0].lower() + id[1:])
$endfor
	, `$(name)_T (output) out
	);

$for((id, type, delay) in parts)
`$(type)_T (wire) $(id[0].lower() + id[1:])\$;
Util_Delay_array #
	( .WIDTH (`$(type)_W)
	, .DELAY (DELAYED ? $(id.upper())_DELAY : 0)
	, .RESET ($(id.upper())_RESET)
	) DELAY$(id.upper())
	( .ctrl (ctrl)
	, .in  ($(id[0].lower() + id[1:]))
	, .out ($(id[0].lower() + id[1:])\$)
	);
$endfor

$(name)_pack PIPEPACK
	( .out (out)
$for((id, type, delay) in parts)
	, .$(id[0].lower() + id[1:]) ($(id[0].lower() + id[1:])\$)
$endfor
	);

endmodule

