`include "Mips/Type/Word.v"
`include "Mips/Control/Control.v"
`include "Mips/Pipeline/ExMem/Pipeline.v"
`include "Mips/Pipeline/MemWb/Pipeline.v"

module Mips_Pipeline_MemWb_generate
	( `Mips_Pipeline_ExMem_Pipeline_T(input) pipeIn
	, `Mips_Type_Word_T(input) memOut
	, `Mips_Pipeline_MemWb_Pipeline_T(output) pipeOut
	);

`Mips_Pipeline_MemWb_Pipeline_T(wire) pipeOut$;

`Mips_Pipeline_ExMem_Pipeline_Unpack(pipeIn)

assign pipeOut$ = `Mips_Pipeline_MemWb_Pipeline_Pack_Defaults;
assign pipeOut = pipeOut$;

endmodule
