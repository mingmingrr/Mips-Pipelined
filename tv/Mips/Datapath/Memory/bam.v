`ifndef MIPS_DATAPATH_MEMORY_BAM_I
`define MIPS_DATAPATH_MEMORY_BAM_I

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
	, parameter RESET = ADDR_W'(0)
	)
	( `Data_Control_Control_T               (input)  ctrl
	, `Mips_Control_Signal_Memory_Control_T (input)  control
	, `Mips_Type_Word_T                     (input)  data
	, `Mips_Type_Word_T                     (output) out
	, input [ADDR_W-1:0]  addr
	);

`Util_Math_log2_expr

reg [7:0] memData [0:ADDR_L-1];

integer i;
always @(posedge `Data_Control_Control_Clock(ctrl))
	if(`Data_Control_Control_Reset(ctrl))
		for(i = 0; i < ADDR_L; i = i + 1)
			memData[i] = RESET;
	else if(`Mips_Control_Signal_Memory_Control_WriteEnable(control))
		case(`Mips_Control_Signal_Memory_Control_ByteEnable(control))
			`Mips_Control_Signal_Memory_Signal_ByteEnable_None :
				begin end
			`Mips_Control_Signal_Memory_Signal_ByteEnable_Byte :
				begin memData[addr+0] = `Mips_Type_Word_Byte0(data);
				      end
			`Mips_Control_Signal_Memory_Signal_ByteEnable_Half :
				begin memData[addr+0] = `Mips_Type_Word_Byte0(data);
				      memData[addr+1] = `Mips_Type_Word_Byte1(data);
				      end
			`Mips_Control_Signal_Memory_Signal_ByteEnable_Word :
				begin memData[addr+0] = `Mips_Type_Word_Byte0(data);
				      memData[addr+1] = `Mips_Type_Word_Byte1(data);
				      memData[addr+2] = `Mips_Type_Word_Byte2(data);
				      memData[addr+3] = `Mips_Type_Word_Byte3(data);
				      end
			default :
				begin end
		endcase

`Mips_Type_Byte_T(reg) extbyte;
always @(*)
	case(`Mips_Control_Signal_Memory_Control_ByteEnable(control))
		`Mips_Control_Signal_Memory_Signal_ByteEnable_None : extbyte = 8'b0;
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Byte : extbyte = `Mips_Type_Word_Byte0(data);
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Half : extbyte = `Mips_Type_Word_Byte1(data);
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Word : extbyte = `Mips_Type_Word_Byte3(data);
		default : extbyte = 8'b0;
	endcase

`Mips_Type_Byte_T(reg) extend;
always @(*)
	case(`Mips_Control_Signal_Memory_Control_ByteExtend(control))
		`Mips_Control_Signal_Memory_Signal_ByteExtend_Unsigned : extend = 8'b0;
		`Mips_Control_Signal_Memory_Signal_ByteExtend_Signed : extend = {8{extbyte[7]}};
	endcase

`Mips_Type_Word_T (reg) out$;
always @(*)
	case(`Mips_Control_Signal_Memory_Control_ByteEnable(control))
		`Mips_Control_Signal_Memory_Signal_ByteEnable_None : out$ = 32'b0;
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Byte : out$ = {{3{extend}}, memData[addr+0]};
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Half : out$ = {{2{extend}}, memData[addr+1], memData[addr+0]};
		`Mips_Control_Signal_Memory_Signal_ByteEnable_Word : out$ = {memData[addr+3], memData[addr+2], memData[addr+1], memData[addr+0]};
		default                                            : out$ = 32'b0;
	endcase
assign out = out$;


endmodule

`endif
