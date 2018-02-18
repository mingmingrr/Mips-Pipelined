`ifndef DATA_ARRAY_PACK_M
`define DATA_ARRAY_PACK_M

`define Data_Array_Pack_T(T,a,b) T [a*b-1:0]

`define Data_Array_Pack_Packed_T(T,a,b,x) T [a*b-1:0] x;
`define Data_Array_Pack_Unpacked_T(T,a,b,x) T [b-1:0] x [a-1:0];

`define Data_Array_Pack_at(a,b,x,i) x[b*i+b-1:b*i]

`define Data_Array_Pack_unpack(a,b,x,y,i,l) \
	genvar i; \
	generate \
		for(i = 0; i < a; i = i + 1) begin : l \
			assign y[i] = x[b*i+b-1:b*i]; end \
	endgenerate
`define Data_Array_Pack_unpackDecl(T,a,b,x,y,i,l) \
	`Data_Array_Pack_Unpacked_T(T,a,b,y) \
	`Data_Array_Pack_unpack(a,b,x,y,i,l)

`define Data_Array_Pack_pack(a,b,x,y,i,l) \
	genvar i; \
	generate \
		for(i = 0; i < a; i = i + 1) begin : l \
			assign y[b*i+b-1:b*i] = x[i]; end \
	endgenerate
`define Data_Array_Pack_packDecl(T,a,b,x,y,i,l) \
	`Data_Array_Pack_Unpacked_T(T,a,b,x) \
	`Data_Array_Pack_pack(a,b,x,y,i,l)

`endif

