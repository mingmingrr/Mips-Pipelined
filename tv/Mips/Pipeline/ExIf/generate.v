`include "Mips/Type/Word.v"
`include "Mips/Control/Control.v"
`include "Mips/Type/AluStatus.v"

`include "Mips/Pipeline/ExIf/Pipeline.v"

module Mips_Pipeline_ExIf_generate
	( `Mips_Type_AluStatus_T(input) aluStatus
	, `Mips_Control_Control_T(input) control
	, `Mips_Pipeline_ExIf_Pipeline_T(output) pipeOut
	);

`Mips_Pipeline_ExIf_Pipeline_T(wire) pipeOut$;

assign pipeOut$ = `Mips_Pipeline_ExIf_Pipeline_Pack_Defaults;
assign pipeOut = pipeOut$;

endmodule
