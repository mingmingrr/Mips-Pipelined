`include "Mips/Type/Word.v"

`include "Mips/Control/Signal/Alu/Signal/Data2Source.v"

module Mips_Datapath_Alu_data2
	( `Mips_Control_Signal_Alu_Signal_Data2Source_T (input) control
	, `Mips_Type_Word_T (input) immediate
	, `Mips_Type_Word_T (input) regPort2
	, `Mips_Type_Word_T (output) data2
	);

`Mips_Type_Word_T (reg) data2$ ;
always @(*)
	case(control)
		`Mips_Control_Signal_Alu_Signal_Data2Source_Immediate : data2$ = immediate;
		`Mips_Control_Signal_Alu_Signal_Data2Source_Register  : data2$ = regPort2;
		default                                               : data2$ = regPort2;
	endcase
assign data2 = data2$;

endmodule
