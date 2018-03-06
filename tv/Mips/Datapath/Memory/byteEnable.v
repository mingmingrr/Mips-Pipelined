`include "Mips/Control/Signal/Memory/Signal/ByteEnable.v"

module Mips_Datapath_Memory_byteEnable
	( `Mips_Control_Signal_Memory_Signal_ByteEnable_T(input) control
	, output [3:0] byteEnable
	);

reg [3:0] byteEnable$;
always @(*)
	case(control)
		`Mips_Control_Signal_Memory_Signal_ByteEnable_None : byteEnable$ = 4'b0000;
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Byte : byteEnable$ = 4'b0001;
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Half : byteEnable$ = 4'b0011;
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Word : byteEnable$ = 4'b1111;
		default                                            : byteEnable$ = 4'b0000;
	endcase
assign byteEnable = byteEnable$;

endmodule

