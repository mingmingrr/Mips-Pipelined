`include "Mips/Type/Word.v"
`include "Mips/Type/RegAddr.v"
`include "Mips/Instruction/Format/RFormat.v"

`include "Mips/Control/Signal/Register/Signal/Port2AddrSource.v"

module Mips_Datapath_Register_rd2Addr
	( `Mips_Control_Signal_Register_Signal_Port2AddrSource_T(input) control
	, `Mips_Type_Word_T(input) instruction
	, `Mips_Type_RegAddr_T(output) rd2Addr
	);

`Mips_Type_RegAddr_T (wire) rs;
`Mips_Type_RegAddr_T (wire) rt;
`Mips_Type_RegAddr_T (wire) rd;
assign rs = `Mips_Instruction_Format_RFormat_Rs(instruction);
assign rd = `Mips_Instruction_Format_RFormat_Rd(instruction);
assign rt = `Mips_Instruction_Format_RFormat_Rt(instruction);

`Mips_Type_RegAddr_T (reg) rd2Addr$;
always @(*)
	case(control)
		`Mips_Control_Signal_Register_Signal_Port2AddrSource_Rs   : rd2Addr$ = rs;
		`Mips_Control_Signal_Register_Signal_Port2AddrSource_Rt   : rd2Addr$ = rt;
		`Mips_Control_Signal_Register_Signal_Port2AddrSource_None : rd2Addr$ = 5'b0;
		default                                                   : rd2Addr$ = 5'b0;
	endcase
assign rd2Addr = rd2Addr$;

endmodule

