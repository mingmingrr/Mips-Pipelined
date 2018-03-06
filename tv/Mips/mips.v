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

`include "Mips/Control/Control.v"
`include "Mips/Control/generate.v"

`include "Mips/Pipeline/IfId/generate.v"
`include "Mips/Pipeline/IdEx/generate.v"
`include "Mips/Pipeline/ExMem/generate.v"
`include "Mips/Pipeline/MemWb/generate.v"

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

`Mips_Type_Word_T       (wire) instruction;
`Mips_Control_Control_T (wire) control;

`Mips_Type_Word_T (wire) ramOut   ;

`Mips_Type_Word_T (wire) regPort1 ;
`Mips_Type_Word_T (wire) regPort2 ;
wire reg_port_eq ;

`Mips_Type_Word_T           (wire) aluResult ;
`Mips_Datapath_Alu_Status_T (wire) aluStatus ;

`Mips_Pipeline_IfId_Pipeline_T  (wire) pipeIfId  ;
`Mips_Pipeline_IdEx_Pipeline_T  (wire) pipeIdEx  ;
`Mips_Pipeline_ExMem_Pipeline_T (wire) pipeExMem ;
`Mips_Pipeline_MemWb_Pipeline_T (wire) pipeMemWb ;

`Mips_Type_Word_T (wire) pcNext ;

Mips_Datapath_Pc_datapath #
	( .FILE    (FILE)
	, .ADDR_L  (ADDR_L)
	, .ADDR_W  (ADDR_W)
	, .DATA_W  (`Mips_Type_Word_W)
	) PC
	( .aluStatus   (aluStatus)
	, .control     (`Mips_Control_Control_Pc(control))
	, .ctrl        (ctrl)
	, .instruction (instruction)
	, .regPort1    (regPort1)
	, .regPortEq   (reg_port_eq)
	, .addrNext    (pcNext)
	, .addrCurr    (pcAddr)
	);

Mips_Pipeline_IfId_generate IFID
	( .instruction (instruction)
	, .pcAddr      (pcAddr)
	, .pipeOut     (pipeIfId)
	);

Mips_Control_generate CTRL
	( .instruction (instruction)
	, .control (control)
	);

Mips_Datapath_Register_datapath REG
	( .ctrl        (ctrl)
	, .control     (`Mips_Control_Control_Register(control))
	, .pcAddr      (pcAddr)
	, .ramOut      (ramOut)
	, .aluResult   (aluResult)
	, .instruction (instruction)
	, .port1       (regPort1)
	, .port2       (regPort2)
	, .portEq      (reg_port_eq)
	);

Mips_Pipeline_IdEx_generate IDEX
	( .pipeIn   (pipeIfId)
	, .control  (control)
	, .regPort1 (regPort1)
	, .regPort2 (regPort2)
	, .pipeOut  (pipeIdEx)
	);

Mips_Datapath_Alu_datapath ALU
	( .ctrl     (ctrl)
	, .pipeIdEx (pipeIdEx)
	, .result   (aluResult)
	, .status   (aluStatus)
	);

Mips_Pipeline_ExMem_generate EXMEM
	( .pipeIn    (pipeIdEx)
	, .aluResult (aluResult)
	, .aluStatus (aluStatus)
	, .pipeOut   (pipeExMem)
	);

Mips_Datapath_Memory_datapath #
	( .ADDR_L  (128)
	) RAM
	( .ctrl      (ctrl)
	, .pipeExMem (pipeExMem)
	, .out       (ramOut)
	);

Mips_Pipeline_MemWb_generate MEMWB
	( .pipeIn  (pipeExMem)
	, .memOut  (ramOut)
	, .pipeOut (pipeMemWb)
	);

endmodule

