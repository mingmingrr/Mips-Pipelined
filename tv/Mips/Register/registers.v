`ifndef REGISTER_REGISTERS_I
`define REGISTER_REGISTERS_I

`include "Util/Math.v"
`include "Data/Control/Control.v"

module Mips_Register_registers #
	( parameter DATA_W = 32
	, parameter ADDR_L = 32
	, parameter ADDR_W = Util_Math_log2(ADDR_L)
	, parameter RESET = ADDR_L'(0)
	)
	( `Data_Control_Control_T(input) ctrl
	, input  [ADDR_W-1:0] rd1Addr
	, output [DATA_W-1:0] rd1Data
	, input  [ADDR_W-1:0] rd2Addr
	, output [DATA_W-1:0] rd2Data
	, input  [ADDR_W-1:0] wrAddr
	, input  [DATA_W-1:0] wrData
	, input               wrEnable
	);

`Util_Math_log2_expr

reg [DATA_W-1:0] regs [0:ADDR_L-1];

assign rd1Data
	= regs[rd1Addr];
	// = rd1Addr == wrAddr
	// ? wrData
	// : regs[rd1Addr]
	// ;

assign rd2Data
	= regs[rd2Addr];
	// = rd2Addr == wrAddr
	// ? wrData
	// : regs[rd2Addr]
	// ;

always @(posedge `Data_Control_Control_Clock(ctrl))
	if(`Data_Control_Control_Reset(ctrl)) begin : wtf
		integer i;
		for(i = 0; i < ADDR_L; i = i + 1)
			begin regs[i] <= RESET; end
	end else if((|wrAddr) && wrEnable)
		regs[wrAddr] <= wrData;

endmodule

`endif
