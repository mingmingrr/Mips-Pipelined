`include "Util/Math.v"
`include "Data/Control/Control.v"
`include "Mips/Control/Signal/Memory/Control.v"
`include "Mips/Control/Signal/Memory/Signal/ByteEnable.v"
`include "Mips/Control/Signal/Memory/Signal/ByteExtend.v"
`include "Mips/Control/Signal/Memory/Signal/WriteEnable.v"
`include "Mips/Type/Word.v"
`include "Mips/Type/Byte.v"

module Mips_Datapath_Memory_bam #
	( parameter ADDR_L = 64
	, parameter ADDR_W = Util_Math_log2(ADDR_L)
	, parameter RESET = 8'b0
	)
	( `Data_Control_Control_T               (input)  ctrl
	, `Mips_Control_Signal_Memory_Control_T (input)  control
	, `Mips_Type_Word_T                     (input)  data
	, `Mips_Type_Word_T                     (output) out
	, input [ADDR_W-1:0] addr
	);

`Util_Math_log2_expr

`Mips_Type_Byte_T(reg) memData [0:ADDR_L-1];

`Mips_Type_Word_T(wire) memRead;
assign memRead =
	{ memData[addr+3]
	, memData[addr+2]
	, memData[addr+1]
	, memData[addr+0]
	};

reg [3:0] byteEnable;
always @(*)
	case(`Mips_Control_Signal_Memory_Control_ByteEnable(control))
		`Mips_Control_Signal_Memory_Signal_ByteEnable_None : byteEnable = 4'b0000;
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Byte : byteEnable = 4'b0001;
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Half : byteEnable = 4'b0011;
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Word : byteEnable = 4'b1111;
		default                                            : byteEnable = 4'b0000;
	endcase

integer i;
always @(posedge `Data_Control_Control_Clock(ctrl))
	if(`Data_Control_Control_Reset(ctrl))
		for(i = 0; i < ADDR_L; i = i + 1)
			memData[i] = RESET;
	else if(`Mips_Control_Signal_Memory_Control_WriteEnable(control)) begin
		if(byteEnable[3]) memData[addr+3] = `Mips_Type_Word_Byte3(data);
		if(byteEnable[2]) memData[addr+2] = `Mips_Type_Word_Byte2(data);
		if(byteEnable[1]) memData[addr+1] = `Mips_Type_Word_Byte1(data);
		if(byteEnable[0]) memData[addr+0] = `Mips_Type_Word_Byte0(data);
	end

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

