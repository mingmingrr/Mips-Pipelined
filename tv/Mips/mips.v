`include "Data/Array/Array.v"
`include "Data/Control/Control.v"

`include "Mips/Type/RegAddr.v"
`include "Mips/Type/Word.v"
`include "Mips/Type/Byte.v"
`include "Mips/Type/Bit.v"
`include "Util/Math.v"

`include "Data/Memory/rom.v"

`include "Mips/Instruction/Format/IFormat.v"
`include "Mips/Instruction/Format/JFormat.v"
`include "Mips/Instruction/Format/RFormat.v"

`include "Mips/Datapath/Alu/datapath.v"
`include "Mips/Datapath/Pc/datapath.v"
`include "Mips/Datapath/Memory/datapath.v"
`include "Mips/Datapath/Register/datapath.v"
`include "Mips/Datapath/Instruction/datapath.v"

`include "Mips/Control/Control.v"
`include "Mips/Control/generate.v"

`define Mips_mips_Addr_T(T) T [ADDR_W-1:0]

module Mips_mips #
	( parameter FILE = "asm/test0.mif"
	, parameter ADDR_L = 64
	, parameter ADDR_W = Util_Math_log2(ADDR_L)
	)
	( `Data_Control_Control_T(input) ctrl
	, `Mips_Type_Word_T(output)      pcAddr
	);

`Util_Math_log2_expr

`Mips_Type_Word_T (wire) instruction;
`Mips_Control_Control_T (wire) control;
`Mips_Type_Word_T (wire) rom_addr;

wire [8:0] ram_addr  ;
`Mips_Type_Word_T (wire) ram_data  ;
`Mips_Type_Word_T (wire) ram_out   ;

`Mips_Type_Word_T (wire) reg_port1 ;
`Mips_Type_Word_T (wire) reg_port2 ;

`Mips_Type_Word_T  (wire) alu_result ;
`Mips_Datapath_Alu_Status_T (wire) alu_status ;

`Mips_Type_Word_T(wire) pc_addr_curr;
`Mips_Type_Word_T(wire) pc_addr_next;

Mips_Datapath_Instruction_datapath #
	( .FILE    (FILE)
	, .ADDR_L  (ADDR_L)
	, .ADDR_W  (ADDR_W)
	, .DATA_W  (`Mips_Type_Word_W)
	) INST
	( .ctrl        (ctrl)
	, .romAddr     (rom_addr)
	, .instruction (instruction)
	, .control     (control)
	);

Mips_Datapath_Memory_datapath #
	( .ADDR_L  (128)
	) RAM
	( .addr  (ram_addr)
	, .data  (ram_data)
	, .out   (ram_out)
	, .control (`Mips_Control_Control_Memory(control))
	, .ctrl  (ctrl)
	);

Mips_Datapath_Alu_datapath ALU
	( .ctrl (ctrl)
	, .control  (`Mips_Control_Control_Alu(control))
	, .regPort1 (reg_port1)
	, .regPort2 (reg_port2)
	, .instruction (instruction)
	, .result (alu_result)
	, .status (alu_status)
	);

Mips_Datapath_Pc_datapath PC
	( .status  (alu_status)
	, .control (`Mips_Control_Control_Pc(control))
	, .ctrl   (ctrl)
	, .instruction (instruction)
	, .regPort1    (reg_port1)
	, .addrNext (pc_addr_next)
	, .addrCurr (pc_addr_curr)
	);

Mips_Datapath_Register_datapath REG
	( .ctrl    (ctrl)
	, .control (`Mips_Control_Control_Register(control))
	, .pcAddr  (pc_addr_curr)
	, .ramOut  (ram_out)
	, .aluResult (alu_result)
	, .instruction (instruction)
	, .port1   (reg_port1)
	, .port2   (reg_port2)
	);

assign rom_addr = pc_addr_next;
assign ram_addr = alu_result[8:0];
assign ram_data = reg_port2;
assign pcAddr = pc_addr_curr;

endmodule

