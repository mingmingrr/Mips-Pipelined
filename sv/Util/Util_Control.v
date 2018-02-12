// vim: set ft=verilog:

`ifndef UTIL_CONTROL_M
`define UTIL_CONTROL_M

`define Util_Control_Clock_I 1
`define Util_Control_Clock_W 1
`define Util_Control_Clock_T(x) T
`define Util_Control_Clock(x) x[`Util_Control_Clock_I]

`define Util_Control_Reset_I 0
`define Util_Control_Reset_W 1
`define Util_Control_Reset_T(T) T
`define Util_Control_Reset(x) x[`Util_Control_Reset_I]

`define Util_Control_W 2
`define Util_Control_T(T) T [`Util_Control_W-1:0]
`define Util_Control_Init(Clock, Reset) \
	{ `Util_Control_Clock'(Clock) \
	, `Util_Control_Reset'(Reset) \
	}

`endif
