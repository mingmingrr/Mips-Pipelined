`ifndef PC_PC_I
`define PC_PC_I

`include "../Util/Util_Math.v"
`include "../Util/Util_Control.v"
`include "../Pc/Pc_Action.v"

module Pc_pc #
	( parameter ADDR_W = 32
	, parameter OFFSET_W = 16
	, parameter JUMP_W = 26
	, parameter STEP = 4
	, parameter SKIP = Util_Math_log2(STEP)
	, parameter RESET = ADDR_W'(0)
	)
	( `Util_Control_T(input) ctrl
	, `Pc_Action_T(input) act
	, input [OFFSET_W-1:0] offset
	, input [JUMP_W-1:0] jump
	, output [ADDR_W-1:0] addr
	);

`Util_Math_log2_expr

reg [ADDR_W-1:0] pc;
assign addr = pc;

wire signed [OFFSET_W-1:0] offset$;
assign offset$ = offset;

always @(posedge `Util_Control_Clock(ctrl))
	if(`Util_Control_Reset(ctrl))
		pc <= RESET;
	else
		case(act)
			`Pc_Action_None   : pc <= pc;
			`Pc_Action_Inc    : pc <= pc + STEP;
			`Pc_Action_Branch : pc <= pc + (ADDR_W'(offset$) << SKIP);
			`Pc_Action_Jump   : pc <= {pc[ADDR_W-1:JUMP_W+SKIP], jump, SKIP'(0)};
			default : pc <= pc;
		endcase

endmodule

`endif

