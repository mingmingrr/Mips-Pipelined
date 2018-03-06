`include "Mips/Type/Word.v"
`include "Mips/Pipeline/IfId/Pipeline.v"
`include "Mips/Pipeline/IdEx/Pipeline.v"

module Mips_Pipeline_IdEx_generate
	( `Mips_Pipeline_IfId_Pipeline_T(input) pipeIn
	, `Mips_Control_Control_T(input) control
	, `Mips_Type_Word_T(input) regPort1
	, `Mips_Type_Word_T(input) regPort2
	, `Mips_Pipeline_IdEx_Pipeline_T(output) pipeOut
	);

`Mips_Pipeline_IdEx_Pipeline_T(wire) pipeOut$;

`Mips_Pipeline_IfId_Pipeline_Decl
assign `Mips_Pipeline_IfId_Pipeline_Pack_Defaults = pipeIn;

assign pipeOut$ = `Mips_Pipeline_IdEx_Pipeline_Pack_Defaults;
assign pipeOut = pipeOut$;

endmodule
