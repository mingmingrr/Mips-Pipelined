// vim: set ft=verilog:

`ifndef UTIL_ARRAY_M
`define UTIL_ARRAY_M

`define Util_Array_setAll(a,l,i,x) \
	for(i = 0; i < l; i = i + 1) \
		a[i] = x;

`endif

