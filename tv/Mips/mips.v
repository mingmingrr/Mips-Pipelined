`ifndef MIPS_MIPS_I
`define MIPS_MIPS_I

`include "Data/Control/Control.v"
`include "Data/Memory/ram.v"
`include "Data/Memory/rom.v"
`include "Mips/Alu/hilo.v"
`include "Mips/Alu/Func.v"
`include "Mips/Alu/hilo.v"
`include "Mips/Pc/pc.v"
`include "Mips/Instruction/Format/IFormat.v"
`include "Mips/Instruction/Format/JFormat.v"
`include "Mips/Instruction/Format/RFormat.v"
`include "Mips/Instruction/OpFunc/OpFunc.v"
`include "Mips/Instruction/OpFunc/aluFuncDecode.v"
`include "Mips/Instruction/OpFunc/instToOpFunc.v"
`include "Mips/Control/Control.v"
`include "Mips/Control/generate.v"
`include "Mips/Register/registers.v"
`include "Mips/Type/RegAddr.v"
`include "Mips/Type/Word.v"
`include "Mips/Type/Bit.v"
`include "Util/Math.v"

`define Mips_mips_Addr_T [ADDR_W-1:0] = Util_Math_log2(ADDR_L)

module Mips_mips #
	( parameter FILE = "asm/test0.mif"
	, parameter ADDR_L = 64
	, parameter ADDR_W = Util_Math_log2(ADDR_L)
	)
	( `Data_Control_Control_T(input) ctrl
	);

`Util_Math_log2_expr

`Mips_Alu_Func_T                  (wire) alu_func    ;
`Mips_Control_Control_T           (wire) control     ;
`Mips_Instruction_OpFunc_OpFunc_T (wire) opFunc      ;
`Mips_Type_Word_T                 (wire) instruction ;

`Mips_mips_Addr_T (wire) ram_addr ;
`Mips_Type_Bit_T  (wire) ram_wren ;
`Mips_Type_Word_T (wire) ram_data ;
`Mips_Type_Word_T (wire) ram_out  ;

Data_Memory_ram #
	( .FILE    (FILE)
	, .ADDR_L  (ADDR_L)
	, .ADDR_W  (ADDR_W)
	, .DATA_W  (`Mips_Type_Word_W)
	) GRAM
	( .addr  (ram_addr)
	, .bytes (4'b1100)
	, .data  (ram_data)
	, .wren  (ram_wren)
	, .ctrl  (ctrl)
	, .out   (ram_out)
	);

`Mips_mips_Addr_T (wire) rom_addr ;
`Mips_Type_Word_T (wire) rom_out  ;

Data_Memory_rom #
	( .FILE    (FILE)
	, .ADDR_L  (ADDR_L)
	, .ADDR_W  (ADDR_W)
	, .DATA_W  (`Mips_Type_Word_W)
	) GROM
	( .addr  (rom_addr)
	, .ctrl  (ctrl)
	, .out   (rom_out)
	);

`Mips_Type_RegAddr_T (wire) reg_rd1_addr  ;
`Mips_Type_RegAddr_T (reg ) reg_rd1_addr$ ;
`Mips_Type_Word      (wire) reg_rd1_data  ;
`Mips_Type_RegAddr_T (wire) reg_rd2_addr  ;
`Mips_Type_RegAddr_T (reg ) reg_rd2_addr$ ;
`Mips_Type_Word      (wire) reg_rd2_data  ;
`Mips_Type_RegAddr_T (wire) reg_wr_addr   ;
`Mips_Type_RegAddr_T (reg ) reg_wr_addr$  ;
`Mips_Type_Word      (wire) reg_wr_data   ;
`Mips_Type_Word      (reg ) reg_wr_data$  ;

assign reg_rd1_addr = reg_rd1_addr$ ;
assign reg_rd2_addr = reg_rd2_addr$ ;
assign reg_wr_addr  = reg_wr_addr$  ;
assign reg_wr_data  = reg_wr_data$  ;

Mips_Register_registers #
	( .DATA_W (32)
	, .ADDR_L (32)
	) GREG
	( .ctrl    (ctrl)
	, .rd1Addr (reg_rd1_addr)
	, .rd1Data (reg_rd1_data)
	, .rd2Addr (reg_rd2_addr)
	, .rd2Data (reg_rd2_data)
	, .wrAddr  (reg_wr_addr )
	, .wrData  (reg_wr_data )
	, .wrEnable (`Mips_Control_Control_RegisterWriteEnable(control))
	);

`Mips_Type_Word_T    (wire) alu_data1  ;
`Mips_Type_Word_T    (wire) alu_data2  ;
`Mips_Type_Word_T    (reg ) alu_data2$ ;
`Mips_Type_Word_T    (wire) alu_result ;
`Mips_Type_RegAddr_T (wire) alu_shamt  ;
`Mips_Type_RegAddr_T (reg ) alu_shamt$ ;
`Mips_Alu_Status_T   (wire) alu_status ;

assign alu_data2 = alu_data2$;
assign alu_shamt = alu_shamt$;

Mips_Alu_hilo #
	( .DATA_W (32)
	) GALU
	( .ctrl (ctrl)
	, .func   (alu_func)
	, .data1  (alu_data1)
	, .data2  (alu_data2)
	, .result (alu_result)
	, .status (alu_status)
	);

Mips_Instruction_OpFunc_aluFuncDecode GALUDEC
	( .opFunc (opFunc)
	, .func   (alu_func)
	);

Mips_Control_generate GCTRLGEN
	( .opFunc   (opFunc)
	, .control  (control)
	);

Mips_Instruction_OpFunc_instToOpFunc GITOOF
	( .op     (`Mips_Instruction_Format_RFormat_Op(instruction))
	, .func   (`Mips_Instruction_Format_RFormat_Func(instruction))
	, .opFunc (opFunc)
	);

`Mips_Pc_Action_T(wire) pc_action;
Mips_Pc_control GPCCTRL
	( .control  (control)
	, .zeroflag (alu_zero)
	, .zeroreg  (~(|reg_rd2_data))
	, .action   (pc_action)
	);

`Mips_Type_Word_T(wire) pc_addr;
Mips_Pc_pc #
	( .ADDR_W (32)
	) GPC
	( .ctrl (ctrl)
	, .act  (pc_action)
	, .offset (`Mips_Instruction_Format_IFormat_Imm(instruction))
	, .jump   (`Mips_Instruction_Format_JFormat_Target(instruction))
	, .addr (pc_addr)
	);

assign rom_addr = pc_addr[7:2];
assign ram_addr = alu_result[7:2];
assign ram_data = reg_rd2_data;
assign instruction = rom_out;
assign alu_data1 = reg_rd1_data;

wire [4:0] rs, rt, rd;
assign rs = `Mips_Instruction_Format_RFormat_Rs(instruction);
assign rt = `Mips_Instruction_Format_RFormat_Rt(instruction);
assign rd = `Mips_Instruction_Format_RFormat_Rd(instruction);

wire [15:0] immediate;
assign immediate = `Mips_Instruction_Format_IFormat_Imm(instruction);


endmodule

`endif
