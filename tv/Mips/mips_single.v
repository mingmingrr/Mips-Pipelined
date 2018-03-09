`include "Data/Control/Control.v"

`include "Mips/Type/Word.v"
`include "Mips/Type/AluStatus.v"
`include "Util/Math.v"

`include "Mips/Datapath/Alu/datapath.v"
`include "Mips/Datapath/Pc/datapath.v"
`include "Mips/Datapath/Memory/datapath.v"
`include "Mips/Datapath/Register/datapath.v"

`include "Mips/Control/Control.v"
`include "Mips/Control/generate.v"

module Mips_mips_single #
	( parameter FILE = "asm/old/test0.mif"
	, parameter ADDR_L = 64
	, parameter ADDR_W = Util_Math_log2(ADDR_L)
	)
	( `Data_Control_Control_T(input) ctrl
	, `Mips_Type_Word_T(output)      pcAddr
	);

`Util_Math_log2_expr

`Mips_Type_Word_T (wire) instruction ;

`Mips_Control_Control_T (wire) control ;

`Mips_Type_Word_T (wire) memOut ;

`Mips_Type_Word_T (wire) regPort1 ;
`Mips_Type_Word_T (wire) regPort2 ;
wire regPortEq ;

`Mips_Type_Word_T      (wire) aluResult ;
`Mips_Type_AluStatus_T (wire) aluStatus ; // unused

`Mips_Type_Word_T (wire) pcNext ;

Mips_Datapath_Pc_datapath #
	( .FILE    (FILE)
	, .ADDR_L  (ADDR_L)
	, .ADDR_W  (ADDR_W)
	, .DATA_W  (`Mips_Type_Word_W)
	) PC
	( .ctrl (ctrl)
	, .control     (control)
	, .instruction (instruction)
	, .regPort1    (regPort1)
	, .regPortEq   (regPortEq)
	, .addrNext    (pcNext)
	, .addrCurr    (pcAddr)
	);

Mips_Control_generate CTRL
	( .instruction (instruction)
	, .control (control)
	);

Mips_Datapath_Register_datapath REG
	( .ctrl (ctrl)
	, .writeControl     (control)
	, .readInstruction  (instruction)
	, .writeInstruction (instruction)
	, .pcAddr           (pcAddr)
	, .memOut           (memOut)
	, .aluResult        (aluResult)
	, .port1            (regPort1)
	, .port2            (regPort2)
	, .portEq           (regPortEq)
	);

Mips_Datapath_Alu_datapath ALU
	( .ctrl (ctrl)
	, .instruction (instruction)
	, .regPort1    (regPort1)
	, .regPort2    (regPort2)
	, .control     (control)
	, .result      (aluResult)
	, .status      (aluStatus)
	);

Mips_Datapath_Memory_datapath #
	( .ADDR_L      (128)
	, .INVERT_CTRL (1)
	) RAM
	( .ctrl (ctrl)
	, .aluResult (aluResult)
	, .regPort2  (regPort2)
	, .control   (control)
	, .out       (memOut)
	);

endmodule

