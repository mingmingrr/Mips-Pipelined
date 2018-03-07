`include "Mips/Type/Word.v"
`include "Mips/Type/RegAddr.v"
`include "Mips/Instruction/Format/RFormat.v"

`include "Mips/Control/Signal/Register/Signal/WriteDataSource.v"

module Mips_Datapath_Register_wrData
	( `Mips_Control_Signal_Register_Signal_WriteDataSource_T(input) control
	, `Mips_Type_Word_T(input) memOut
	, `Mips_Type_Word_T(input) pcAddr
	, `Mips_Type_Word_T(input) aluResult
	, `Mips_Type_Word_T(output) wrData
	);

`Mips_Type_Word_T (reg) wrData$;
always @(*)
	case(control)
		`Mips_Control_Signal_Register_Signal_WriteDataSource_Memory : wrData$ = memOut;
		`Mips_Control_Signal_Register_Signal_WriteDataSource_Pc     : wrData$ = pcAddr + 4;
		`Mips_Control_Signal_Register_Signal_WriteDataSource_Alu    : wrData$ = aluResult;
		default                                                     : wrData$ = aluResult;
	endcase
assign wrData = wrData$;

endmodule

