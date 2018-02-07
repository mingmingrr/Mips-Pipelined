`include "../sv/Arith/extend.v"
`include "../sv/Arith/SignedUnsigned.v"
`include "../sv/Util/Control.v"

module extend_tb;

logic [3:0] in  [1:0];
logic [7:0] out [1:0];
`Arith_SignedUnsigned_T(logic) sign;
`Util_Control_T(logic) ctrl;

Arith_extend #
	( .IN_W  (4)
	, .OUT_W (8)
	, .DEPTH (2)
	) DUT
	( .in   (in)
	, .out  (out)
	, .sign (sign)
	, .ctrl (ctrl)
	);

assign sign = `Arith_SignedUnsigned_Signed;

initial `Util_Control_clock(ctrl) = 0;
always #1 `Util_Control_clock(ctrl) = !`Util_Control_clock(ctrl);

initial begin
	#0;
	`Util_Control_reset(ctrl) = 1;
	in[0] = 4'h0;
	in[1] = 4'h0;

	#2;
	`Util_Control_reset(ctrl) = 0;

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
