`include "Util/Math.v"
`include "Data/Control/Control.v"
`include "Data/Control/invert.v"
`include "Data/Memory/bam.v"

`include "Mips/Pipeline/ExMem/Pipeline.v"

`include "Mips/Control/Signal/Memory/Control.v"
`include "Mips/Control/Signal/Memory/Signal/ByteEnable.v"
`include "Mips/Control/Signal/Memory/Signal/ByteExtend.v"
`include "Mips/Control/Signal/Memory/Signal/WriteEnable.v"

`include "Mips/Datapath/Memory/byteEnable.v"
`include "Mips/Datapath/Memory/outMask.v"

`include "Mips/Type/Word.v"

module Mips_Datapath_Memory_datapath #
	( parameter ADDR_L = 64
	, parameter ADDR_W = Util_Math_log2(ADDR_L)
	)
	( `Data_Control_Control_T               (input)  ctrl
	, `Mips_Pipeline_ExMem_Pipeline_T       (input)  pipeExMem
	, `Mips_Type_Word_T                     (output) out
	);

`Util_Math_log2_expr

`Mips_Pipeline_ExMem_Pipeline_Unpack(pipeExMem)

`Mips_Control_Signal_Memory_Control_T(wire) memControl;
assign memControl = `Mips_Control_Control_Memory(control);

`Mips_Type_Word_T (wire) memAddr;
assign memAddr = aluResult;

`Mips_Type_Word_T (wire) memData;
assign memData = regPort2;

wire [3:0] byteEnable;
Mips_Datapath_Memory_byteEnable BYTE
	( .control (`Mips_Control_Signal_Memory_Control_ByteEnable(memControl))
	, .byteEnable (byteEnable)
	);

`Data_Control_Control_T(wire) ctrlInv;
Data_Control_invert CTRLINV
	( .in (ctrl)
	, .out (ctrlInv)
	);

`Mips_Type_Word_T(wire) memOut;
Data_Memory_bam #
	( .ADDR_WORD_L (ADDR_L)
	) BAM
	( .ctrl  (ctrlInv)
	, .addr  (memAddr[ADDR_W+1:0])
	, .data  (memData)
	, .bytes (byteEnable)
	, .out   (memOut)
	, .wren  (`Mips_Control_Signal_Memory_Control_WriteEnable(memControl))
	);

Mips_Datapath_Memory_outMask MASK
	( .control (`Mips_Control_Signal_Memory_Control_ByteEnable(memControl))
	, .in (memOut)
	, .out (out)
	);

endmodule

