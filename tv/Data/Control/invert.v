`include "Data/Control/Control.v"

module Data_Control_invert
	( `Data_Control_Control_T (input)  in
	, `Data_Control_Control_T (output) out
	);

`Data_Control_Control_Reset_T (wire) reset;
`Data_Control_Control_Clock_T (wire) clock;

assign reset =  `Data_Control_Control_Reset(in);
assign clock = !`Data_Control_Control_Clock(in);

assign out = `Data_Control_Control_Pack_Defaults;

endmodule


