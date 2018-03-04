`include "Util/Math.v"
`include "Data/Control/Control.v"
`include "Mips/Control/Signal/Pc/Signal/Action.v"

module Mips_Pc_pc #
	( parameter ADDR_W = 32
	, parameter OFFSET_W = 16
	, parameter JUMP_W = 26
	, parameter STEP = 4
	, parameter SKIP = Util_Math_log2(STEP)
	, parameter RESET = ADDR_W'(32'h400000)
	)
	( `Data_Control_Control_T(input) ctrl
	, `Mips_Control_Signal_Pc_Signal_Action_T(input) action
	, input [OFFSET_W-1:0] offset
	, input [JUMP_W-1:0] jump
	, input [ADDR_W-1:0] jumpr
	, output [ADDR_W-1:0] addrNext
	, output [ADDR_W-1:0] addrCurr
	);

`Util_Math_log2_expr

reg [ADDR_W-1:0] addr_next, addr_reg;
assign addrNext
	= `Data_Control_Control_Reset(ctrl)
	? RESET
	: addr_next
	;
assign addrCurr
	= addr_reg
	;

wire signed [ADDR_W-1:0] offset$;
assign offset$ = {{(ADDR_W-OFFSET_W){offset[OFFSET_W-1]}}, offset};

always @(*)
	case(action)
		`Mips_Control_Signal_Pc_Signal_Action_None   : addr_next = addr_reg ;
		`Mips_Control_Signal_Pc_Signal_Action_Inc    : addr_next = addr_reg + STEP;
		`Mips_Control_Signal_Pc_Signal_Action_Branch : addr_next = addr_reg + (offset$ << SKIP) + STEP;
		`Mips_Control_Signal_Pc_Signal_Action_Jump   : addr_next = {addr_reg[ADDR_W-1:JUMP_W+SKIP], jump, SKIP'(0)};
		`Mips_Control_Signal_Pc_Signal_Action_JumpR  : addr_next = jumpr;
		default                                      : addr_next = addr_reg ;
	endcase

always @(posedge `Data_Control_Control_Clock(ctrl))
	if(`Data_Control_Control_Reset(ctrl))
		addr_reg <= RESET;
	else
		addr_reg <= addr_next;

endmodule


