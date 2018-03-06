`include "Mips/Type/Word.v"
`include "Mips/Control/Control.v"
`include "Mips/Pipeline/IfId/Pipeline.v"

module Mips_Pipeline_IfId_generate
	( `Mips_Type_Word_T(input) instruction
	, `Mips_Pipeline_IfId_Pipeline_T(output) pipeOut
	);

`Mips_Pipeline_IfId_Pipeline_T(wire) pipeOut$;

assign pipeOut$ = `Mips_Pipeline_IfId_Pipeline_Pack_Defaults;
assign pipeOut = pipeOut$;

endmodule

