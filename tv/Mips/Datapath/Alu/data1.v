`include "Mips/Type/Word.v"

`include "Mips/Control/Signal/Alu/Signal/Data1Source.v"

module Mips_Datapath_Alu_data1
	( `Mips_Control_Signal_Alu_Signal_Data1Source_T (input) control
	, `Mips_Type_Word_T (input) shamt
	, `Mips_Type_Word_T (input) regPort1
	, `Mips_Type_Word_T (output) data1
	);

`Mips_Type_Word_T (reg) data1$ ;
always @(*)
	case(control)
		`Mips_Control_Signal_Alu_Signal_Data1Source_Shamt     : data1$ = shamt;
		`Mips_Control_Signal_Alu_Signal_Data1Source_Register  : data1$ = regPort1;
		default                                               : data1$ = regPort1;
	endcase
assign data1 = data1$;

endmodule
