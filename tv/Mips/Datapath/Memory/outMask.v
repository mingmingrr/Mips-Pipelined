`include "Mips/Type/Word.v"

`include "Mips/Control/Signal/Memory/Signal/ByteExtend.v"
`include "Mips/Control/Signal/Memory/Signal/ByteEnable.v"

module Mips_Datapath_Memory_outMask
	( `Mips_Control_Signal_Memory_Signal_ByteEnable_T(input) control
	, `Mips_Type_Word_T(input) in
	, `Mips_Type_Word_T(output) out
	);

reg ext;
always @(*)
	case(control)
		`Mips_Control_Signal_Memory_Signal_ByteExtend_Unsigned : ext = 1'b0;
		`Mips_Control_Signal_Memory_Signal_ByteExtend_Signed   : ext = 1'b1;
		default                                                : ext = 1'b1;
	endcase

reg msb;
always @(*)
	case(control)
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Word : msb = in[31];
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Half : msb = in[15];
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Byte : msb = in[7];
		`Mips_Control_Signal_Memory_Signal_ByteEnable_None : msb = 1'b0;
		default                                            : msb = 1'b0;
	endcase

`Mips_Type_Word_T (reg) out$;
always @(*)
	case(control)
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Word : out$ = in;
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Half : out$ = {{16{ext & msb}}, in[15:0]};
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Byte : out$ = {{24{ext & msb}}, in[7:0]};
		`Mips_Control_Signal_Memory_Signal_ByteEnable_None : out$ = 32'b0;
		default                                            : out$ = 32'b0;
	endcase
assign out = out$;

endmodule


