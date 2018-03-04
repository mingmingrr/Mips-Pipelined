`include "Util/Math.v"
`include "Data/Control/Control.v"
`include "Data/Memory/bam.v"

`include "Mips/Control/Signal/Memory/Control.v"
`include "Mips/Control/Signal/Memory/Signal/ByteEnable.v"
`include "Mips/Control/Signal/Memory/Signal/ByteExtend.v"
`include "Mips/Control/Signal/Memory/Signal/WriteEnable.v"

`include "Mips/Type/Word.v"

module Mips_Datapath_Memory_datapath #
	( parameter ADDR_L = 64
	, parameter ADDR_W = Util_Math_log2(ADDR_L)
	)
	( `Data_Control_Control_T               (input)  ctrl
	, `Mips_Control_Signal_Memory_Control_T (input)  control
	, `Mips_Type_Word_T                     (input)  data
	, `Mips_Type_Word_T                     (output) out
	, input [ADDR_W+1:0] addr
	);

`Util_Math_log2_expr

reg [3:0] memBytes;
`Mips_Type_Word_T(wire) memRead;

Data_Memory_bam #
	( .ADDR_WORD_L (ADDR_L)
	) BAM
	( .ctrl (ctrl)
	, .addr (addr)
	, .data (data)
	, .bytes (memBytes)
	, .out (memRead)
	, .wren (`Mips_Control_Signal_Memory_Control_WriteEnable(control))
	);

always @(*)
	case(`Mips_Control_Signal_Memory_Control_ByteEnable(control))
		`Mips_Control_Signal_Memory_Signal_ByteEnable_None : memBytes = 4'b0000;
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Byte : memBytes = 4'b0001;
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Half : memBytes = 4'b0011;
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Word : memBytes = 4'b1111;
		default                                            : memBytes = 4'b0000;
	endcase

reg extend;
always @(*)
	case(`Mips_Control_Signal_Memory_Control_ByteExtend(control))
		`Mips_Control_Signal_Memory_Signal_ByteExtend_Unsigned : extend = 1'b0;
		`Mips_Control_Signal_Memory_Signal_ByteExtend_Signed   : extend = 1'b1;
		default                                                : extend = 1'b1;
	endcase

reg msb;
always @(*)
	case(`Mips_Control_Signal_Memory_Control_ByteEnable(control))
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Word : msb = memRead[31];
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Half : msb = memRead[15];
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Byte : msb = memRead[7];
		`Mips_Control_Signal_Memory_Signal_ByteEnable_None : msb = 1'b0;
		default                                            : msb = 1'b0;
	endcase

`Mips_Type_Word_T (reg) out$;
always @(*)
	case(`Mips_Control_Signal_Memory_Control_ByteEnable(control))
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Word : out$ = memRead;
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Half : out$ = {{16{extend & msb}}, memRead[15:0]};
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Byte : out$ = {{24{extend & msb}}, memRead[7:0]};
		`Mips_Control_Signal_Memory_Signal_ByteEnable_None : out$ = 32'b0;
		default                                            : out$ = 32'b0;
	endcase
assign out = out$;

endmodule

