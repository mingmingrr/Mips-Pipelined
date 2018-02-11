// vim: set ft=verilog:

`ifndef ARRAY_ARRAY_M
`define ARRAY_ARRAY_M

`define Array_Array_setAll(a,l,i,x) \
	for(i = 0; i < l; i = i + 1) \
		a[i] = x;

`endif

