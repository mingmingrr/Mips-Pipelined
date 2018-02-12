`ifndef REGISTER_REGISTERS_I
`define REGISTER_REGISTERS_I

`include "../Util/Util_Math.v"
`include "../Util/Util_Control.v"

module Register_registers #
	( parameter DATA_W = 32
	, parameter ADDR_L = 32
	, parameter ADDR_W = Util_Math_log2(ADDR_L)
	, parameter RESET = ADDR_L'(0)
	)
	( `Util_Control_T(input) ctrl
	, input  [ADDR_W-1:0] rd1_addr
	, output [DATA_W-1:0] rd1_data
	, input  [ADDR_W-1:0] rd2_addr
	, output [DATA_W-1:0] rd2_data
	, input  [ADDR_W-1:0] wr_addr
	, input  [DATA_W-1:0] wr_data
	, input               wr_en
	);

`Util_Math_log2_expr

reg [DATA_W-1:0] regs [ADDR_L-1:0];

assign rd1_data
	= rd1_addr == wr_addr
	? wr_data
	: regs[rd1_addr]
	;

assign rd2_data
	= rd2_addr == wr_addr
	? wr_data
	: regs[rd2_addr]
	;

always @(posedge `Util_Control_Clock(ctrl))
	if(`Util_Control_Reset(ctrl)) begin : wtf
		integer i;
		for(i = 0; i < ADDR_L; i = i + 1)
			begin regs[i] <= RESET; end
	end else if(!(|wr_addr) && wr_en)
		regs[wr_addr] <= wr_data;

endmodule

`endif
