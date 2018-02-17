`include "../Control/Control_generate.v"

module Control_generate_tb;

`Opcode_OpFunc_T        ( reg  ) opFunc;
`Control_Control_T      ( wire ) control;

Control_generate DUT
	( .opFunc   (opFunc)
	, .control  (control)
	);

initial opFunc = `Opcode_OpFunc_W'(0);
always #1 opFunc = opFunc + 1;

endmodule

