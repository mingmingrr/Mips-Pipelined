// vim: set ft=verilog:

`ifndef UTIL_CONTROL_M
`define UTIL_CONTROL_M

`define Util_Control_T(T) T [1:0]
`define Util_Control_Init(Clock, Reset) {Clock, Reset}

`define Util_Control_Clock(x) x[1]
`define Util_Control_Clock_T(x) T
`define Util_Control_Reset(x) x[0]
`define Util_Control_Reset_T(T) T

`endif
