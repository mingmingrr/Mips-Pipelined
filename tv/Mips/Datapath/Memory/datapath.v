`include "Util/Math.v"
`include "Util/Delay/array.v"
`include "Data/Control/Control.v"
`include "Data/Control/invert.v"
`include "Data/Memory/bam.v"

`include "Mips/Control/Control.v"
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
	, parameter INVERT_CTRL = 1
	)
	( `Data_Control_Control_T (input) ctrl
	, `Mips_Type_Word_T       (input) aluResult
	, `Mips_Type_Word_T       (input) regPort2
	, `Mips_Control_Control_T (input) control
	, `Mips_Type_Word_T       (output) out
	);

`Util_Math_log2_expr

`Mips_Control_Signal_Memory_Control_T (wire) memControl;
assign memControl = `Mips_Control_Control_Memory(control);
`Mips_Control_Signal_Memory_Control_T (reg) memControl$;
always @(posedge `Data_Control_Control_Clock(ctrl))
	memControl$ <= memControl;

`Mips_Type_Word_T (wire) memAddr;
assign memAddr = aluResult;

`Mips_Type_Word_T (wire) memData;
assign memData = regPort2;

wire [3:0] byteEnable;
Mips_Datapath_Memory_byteEnable BYTE
	( .control (`Mips_Control_Signal_Memory_Control_ByteEnable(memControl))
	, .byteEnable (byteEnable)
	);

`Data_Control_Control_T(wire) ctrl$;
generate
	if(INVERT_CTRL)
		Data_Control_invert CTRLINV
			( .in (ctrl)
			, .out (ctrl$)
			);
	else
		assign ctrl$ = ctrl;
endgenerate

`Mips_Type_Word_T(wire) memOut;
Data_Memory_bam #
	( .ADDR_WORD_L (ADDR_L)
	) BAM
	( .ctrl  (ctrl$)
	, .addr  (memAddr[ADDR_W+1:0])
	, .data  (memData)
	, .bytes (byteEnable)
	, .out   (memOut)
	, .wren  (`Mips_Control_Signal_Memory_Control_WriteEnable(memControl))
	);

Mips_Datapath_Memory_outMask MASK
	( .control (`Mips_Control_Signal_Memory_Control_ByteEnable(memControl$))
	, .in (memOut)
	, .out (out)
	);

endmodule

