`include "Mips/Type/Word.v"
`include "Mips/Type/RegAddr.v"
`include "Mips/Instruction/Format/RFormat.v"

`include "Mips/Control/Signal/Register/Signal/WriteAddrSource.v"

module Mips_Datapath_Register_wrAddr
	( `Mips_Control_Signal_Register_Signal_WriteAddrSource_T(input) control
	, `Mips_Type_Word_T(input) instruction
	, `Mips_Type_RegAddr_T(output) wrAddr
	);

`Mips_Type_RegAddr_T (wire) rs;
`Mips_Type_RegAddr_T (wire) rt;
`Mips_Type_RegAddr_T (wire) rd;
assign rs = `Mips_Instruction_Format_RFormat_Rs(instruction);
assign rd = `Mips_Instruction_Format_RFormat_Rd(instruction);
assign rt = `Mips_Instruction_Format_RFormat_Rt(instruction);

`Mips_Type_RegAddr_T (reg) wrAddr$;
always @(*)
	case(control)
		`Mips_Control_Signal_Register_Signal_WriteAddrSource_Rd   : wrAddr$ = rd;
		`Mips_Control_Signal_Register_Signal_WriteAddrSource_Rt   : wrAddr$ = rt;
		`Mips_Control_Signal_Register_Signal_WriteAddrSource_R31  : wrAddr$ = 5'd31;
		`Mips_Control_Signal_Register_Signal_WriteAddrSource_None : wrAddr$ = 5'b0;
		default                                                   : wrAddr$ = 5'b0;
	endcase
assign wrAddr = wrAddr$;

endmodule


