`include "Data/Arith/extend.v"
`include "Data/Arith/SignedUnsigned.v"
`include "Data/Control/Control.v"

module Data_Arith_extend_tb;

logic [3:0] in  [1:0];
logic [7:0] out [1:0];
`Data_Arith_SignedUnsigned_T(logic) sign;
`Data_Control_Control_T(logic) ctrl;

Data_Arith_extend #
	( .IN_W  (4)
	, .OUT_W (8)
	, .DEPTH (2)
	) DUT
	( .in   (in)
	, .out  (out)
	, .sign (sign)
	, .ctrl (ctrl)
	);

assign sign = `Data_Arith_SignedUnsigned_Signed;

initial `Data_Control_Control_Clock(ctrl) = 0;
always #1 `Data_Control_Control_Clock(ctrl) = !`Data_Control_Control_Clock(ctrl);

initial begin
	#0;
	`Data_Control_Control_Reset(ctrl) = 1;
	in[0] = 4'h0;
	in[1] = 4'h0;

	#2;
	`Data_Control_Control_Reset(ctrl) = 0;

	#2;
	in[0] = 4'ha;
	in[1] = 4'h5;

	#2;
	in[0] = 4'h0;
	in[1] = 4'h0;

	#4;
	$finish;
end

endmodule
