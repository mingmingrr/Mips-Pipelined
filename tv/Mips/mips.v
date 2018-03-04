`include "Data/Array/Array.v"
`include "Data/Control/Control.v"
`include "Data/Control/invert.v"
`include "Data/Memory/ram.v"
`include "Data/Memory/rom.v"
`include "Mips/Instruction/Format/IFormat.v"
`include "Mips/Instruction/Format/JFormat.v"
`include "Mips/Instruction/Format/RFormat.v"
`include "Mips/Instruction/OpFunc/OpFunc.v"
`include "Mips/Instruction/OpFunc/decode.v"
`include "Mips/Instruction/Category/categorize.v"
`include "Mips/Instruction/Category/Category.v"
`include "Mips/Datapath/Alu/datapath.v"
`include "Mips/Datapath/Pc/datapath.v"
`include "Mips/Datapath/Memory/bam.v"
`include "Mips/Datapath/Immediate/extendShift.v"
`include "Mips/Datapath/Register/datapath.v"
`include "Mips/Control/Type/Control.v"
`include "Mips/Control/Type/generate.v"
`include "Mips/Type/RegAddr.v"
`include "Mips/Type/Word.v"
`include "Mips/Type/Byte.v"
`include "Mips/Type/Bit.v"
`include "Util/Math.v"

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

`Mips_Instruction_OpFunc_OpFunc_T (wire) opFunc;
Mips_Instruction_OpFunc_decode ITOOF_G
	( .op     (`Mips_Instruction_Format_RFormat_Op(instruction))
	, .func   (`Mips_Instruction_Format_RFormat_Func(instruction))
	, .opFunc (opFunc)
	);

`Mips_Instruction_Category_Category_T(wire) category;
Mips_Instruction_Category_categorize CATAGORY_G
	( .opFunc   (opFunc)
	, .branchOp (`Mips_Instruction_Format_RFormat_Rt(instruction))
	, .category (category)
	);

`Mips_Control_Type_Control_T (wire) control;
Mips_Control_Type_generate CTRLGEN_G
	( .opFunc   (opFunc)
	, .category (category)
	, .control  (control)
	);

`Data_Control_Control_T(wire) ctrl_inverted;
Data_Control_invert CTRLINV_G
	( .in (ctrl)
	, .out (ctrl_inverted)
	);

wire [8:0] ram_addr  ;
`Mips_Type_Word_T (wire) ram_data  ;
`Mips_Type_Word_T (wire) ram_out   ;
Mips_Datapath_Memory_bam #
	( .ADDR_L  (128)
	) RAM_G
	( .addr  (ram_addr)
	, .data  (ram_data)
	, .out   (ram_out)
	, .control (`Mips_Control_Type_Control_Memory(control))
	, .ctrl  (ctrl_inverted)
	);

`Mips_mips_Addr_T (wire) rom_addr ;
`Mips_Type_Word_T (wire) rom_out  ;
Data_Memory_rom #
	( .FILE    (FILE)
	, .ADDR_L  (ADDR_L)
	, .ADDR_W  (ADDR_W)
	, .DATA_W  (`Mips_Type_Word_W)
	) ROM_G
	( .addr  (rom_addr)
	, .ctrl  (ctrl)
	, .out   (rom_out)
	);

`Mips_Type_Word_T (wire) immediate;
Mips_Datapath_Immediate_extendShift IMM_G
	( .control (`Mips_Control_Type_Control_Immediate(control))
	, .immIn   (`Mips_Instruction_Format_IFormat_Imm(instruction))
	, .immOut  (immediate)
	);

`Mips_Type_Word_T (wire) reg_port1 ;
`Mips_Type_Word_T (wire) reg_port2 ;

`Mips_Type_Word_T  (wire) alu_shamt  ;
`Mips_Type_Word_T  (wire) alu_result ;
`Mips_Datapath_Alu_Status_T (wire) alu_status ;
Mips_Datapath_Alu_datapath ALU
	( .ctrl (ctrl)
	, .control  (`Mips_Control_Type_Control_Alu(control))
	, .opFunc   (opFunc)
	, .regPort1 (reg_port1)
	, .regPort2 (reg_port2)
	, .shamt (alu_shamt)
	, .immediate (immediate)
	, .result (alu_result)
	, .status (alu_status)
	);
assign alu_shamt = 32'(`Mips_Instruction_Format_RFormat_Shamt(instruction));

`Mips_Type_Word_T(wire) pc_addr_curr, pc_addr_next;
Mips_Datapath_Pc_datapath PC
	( .status  (alu_status)
	, .control (`Mips_Control_Type_Control_Pc(control))
	, .ctrl   (ctrl)
	, .instruction (instruction)
	, .regPort1    (reg_port1)
	, .addrNext (pc_addr_next)
	, .addrCurr (pc_addr_curr)
	);

Mips_Datapath_Register_datapath REG
	( .ctrl    (ctrl)
	, .control (`Mips_Control_Type_Control_Register(control))
	, .pcAddr  (pc_addr_curr)
	, .ramOut  (ram_out)
	, .aluResult (alu_result)
	, .instruction (instruction)
	, .port1   (reg_port1)
	, .port2   (reg_port2)
	);

assign rom_addr = pc_addr_next[7:2];
assign ram_addr = alu_result[8:0];
assign ram_data = reg_port2;
assign instruction = rom_out;
assign pcAddr = pc_addr_curr;

endmodule

