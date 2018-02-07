// vim: set ft=verilog:

`ifndef UTIL_PACK_M
`define UTIL_PACK_M

`define Util_Pack_T(T,a,b) T [a*b-1:0]

`define Util_Pack_Packed_T(T,a,b,x) T [a*b-1:0] x;
`define Util_Pack_Unpacked_T(T,a,b,x) T [b-1:0] x [a-1:0];

`define Util_Pack_at(a,b,x,i) x[b*i+b-1:b*i]

`define Util_Pack_unpack(a,b,x,y,i) \
	genvar i; \
	generate \
		for(i = 0; i < a; i = i + 1) \
			assign y[i] = x[b*i+b-1:b*i]; \
	endgenerate
`define Util_Pack_unpackDecl(T,a,b,x,y,i) \
	`Util_Pack_Unpacked_T(T,a,b,y) \
	`Util_Pack_unpack(a,b,x,y,i)

`define Util_Pack_pack(a,b,x,y,i) \
	genvar i; \
	generate \
		for(i = 0; i < a; i = i + 1) \
			assign y[b*i+b-1:b*i] = x[i]; \
	endgenerate
`define Util_Pack_packDecl(T,a,b,x,y,i) \
	`Util_Pack_Unpacked_T(T,a,b,x) \
	`Util_Pack_pack(a,b,x,y,i)

`endif

