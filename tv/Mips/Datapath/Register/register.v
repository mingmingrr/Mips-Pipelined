`include "Util/Math.v"
`include "Data/Control/Control.v"
`include "Mips/Type/Word.v"
`include "Mips/Type/RegAddr.v"

module Mips_Datapath_Register_register #
	( parameter RESET = `Mips_Type_Word_W'(0)
	)
	( `Data_Control_Control_T (input ) ctrl
	, `Mips_Type_RegAddr_T    (input ) rd1Addr
	, `Mips_Type_RegAddr_T    (input ) rd2Addr
	, `Mips_Type_RegAddr_T    (input ) wrAddr
	, `Mips_Type_Word_T       (output) rd1Data
	, `Mips_Type_Word_T       (output) rd2Data
	, `Mips_Type_Word_T       (input ) wrData
	, input                            wrEnable
	);

`Util_Math_log2_expr

`Mips_Type_Word_T(reg) regs [0:31];

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
		for(i = 0; i < 32; i = i + 1)
			begin regs[i] <= RESET; end
	end else if((|wrAddr) && wrEnable)
		regs[wrAddr] <= wrData;

endmodule

