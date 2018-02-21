`ifndef DATA_ARRAY_ARRAY_M
`define DATA_ARRAY_ARRAY_M

`define Data_Array_Array_setAll(a,l,i,x) \
	for(i = 0; i < l; i = i + 1) \
		a[i] = x;

`define Data_Array_Array_subIndex(a, i) \
	a[i]

`define Data_Array_Array_subRange(a, i, w) \
	a[i+w-1:i]

`endif

