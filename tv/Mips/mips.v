`ifndef MIPS_MIPS_I
`define MIPS_MIPS_I

`include "Data/Array/Array.v"
`include "Data/Control/Control.v"
`include "Data/Control/invert.v"
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
`include "Mips/Datapath/Pc/action.v"
`include "Mips/Datapath/Memory/bam.v"
`include "Mips/Control/Control.v"
`include "Mips/Control/generate.v"
`include "Mips/Register/registers.v"
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
	);

`Util_Math_log2_expr

`Mips_Type_Word_T (wire) instruction;

`Mips_Instruction_OpFunc_OpFunc_T (wire) opFunc;
Mips_Instruction_OpFunc_instToOpFunc ITOOF_G
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

`Mips_Control_Control_T (wire) control;
Mips_Control_generate CTRLGEN_G
	( .opFunc   (opFunc)
	, .category (category)
	, .control  (control)
	);

wire [9:0] ram_addr  ;
`Mips_Type_Word_T (wire) ram_data  ;
`Mips_Type_Word_T (wire) ram_out   ;
Mips_Datapath_Memory_bam #
	( .ADDR_L  (1 << 10)
	) RAM_G
	( .addr  (ram_addr)
	, .data  (ram_data)
	, .out   (ram_out)
	, .control (`Mips_Control_Control_Memory(control))
	, .ctrl  (ctrl)
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

`Mips_Type_RegAddr_T (wire) reg_rd1_addr ;
`Mips_Type_Word_T    (wire) reg_rd1_data ;
`Mips_Type_RegAddr_T (wire) reg_rd2_addr ;
`Mips_Type_Word_T    (wire) reg_rd2_data ;
`Mips_Type_RegAddr_T (wire) reg_wr_addr  ;
`Mips_Type_Word_T    (wire) reg_wr_data  ;
Mips_Register_registers #
	( .DATA_W (32)
	, .ADDR_L (32)
	) REG_G
	( .ctrl    (ctrl)
	, .rd1Addr (reg_rd1_addr)
	, .rd1Data (reg_rd1_data)
	, .rd2Addr (reg_rd2_addr)
	, .rd2Data (reg_rd2_data)
	, .wrAddr  (reg_wr_addr )
	, .wrData  (reg_wr_data )
	, .wrEnable (`Data_Array_Array_subIndex(
			control,
			`Mips_Control_Control_Register_I +
			`Mips_Control_Signal_Register_Control_WriteEnable_I
		))
	);


`Mips_Alu_Func_T (wire) alu_func ;
Mips_Instruction_OpFunc_aluFuncDecode ALUDEC_G
	( .opFunc (opFunc)
	, .func   (alu_func)
	);

`Mips_Type_Word_T    (wire) alu_data1  ;
`Mips_Type_Word_T    (wire) alu_data2  ;
`Mips_Type_Word_T    (wire) alu_result ;
`Mips_Alu_Status_T   (wire) alu_status ;
Mips_Alu_hilo #
	( .DATA_W (32)
	) ALU_G
	( .ctrl (ctrl)
	, .func   (alu_func)
	, .data1  (alu_data1)
	, .data2  (alu_data2)
	, .result (alu_result)
	, .status (alu_status)
	);

`Mips_Control_Signal_Pc_Control_Action_T(reg) pc_action;
Mips_Datapath_Pc_action PCACT_G
	( .status (alu_status)
	, .condition (`Data_Array_Array_subRange(
			control,
			`Mips_Control_Control_Pc_I +
			`Mips_Control_Signal_Pc_Control_Condition_I,
			`Mips_Control_Signal_Pc_Control_Condition_W
		))
	, .actionIn (`Data_Array_Array_subRange(
			control,
			`Mips_Control_Control_Pc_I +
			`Mips_Control_Signal_Pc_Control_Action_I,
			`Mips_Control_Signal_Pc_Control_Action_W
		))
	, .actionOut (pc_action)
	);

`Mips_Type_Word_T(wire) pc_addr_curr, pc_addr_next;
Mips_Pc_pc #
	( .ADDR_W (32)
	) PC_G
	( .ctrl   (ctrl)
	, .action (pc_action)
	, .offset (`Mips_Instruction_Format_IFormat_Imm(instruction))
	, .jump   (`Mips_Instruction_Format_JFormat_Target(instruction))
	, .addrNext (pc_addr_next)
	, .addrCurr (pc_addr_curr)
	);

assign rom_addr = pc_addr_next[7:2];
assign ram_addr = alu_result[9:0];
assign ram_data = reg_rd2_data;
assign instruction = rom_out;
assign alu_data1 = reg_rd1_data;

/*
Register
*/

`Mips_Type_RegAddr_T (reg) reg_rd1_addr$;
always @(*)
	case(`Data_Array_Array_subRange(
		control,
		`Mips_Control_Control_Register_I +
		`Mips_Control_Signal_Register_Control_Port1AddrSource_I,
		`Mips_Control_Signal_Register_Control_Port1AddrSource_W
	))
		`Mips_Control_Signal_Register_Signal_Port1AddrSource_Rs   : reg_rd1_addr$ = `Mips_Instruction_Format_RFormat_Rs(instruction);
		`Mips_Control_Signal_Register_Signal_Port1AddrSource_Rt   : reg_rd1_addr$ = `Mips_Instruction_Format_RFormat_Rt(instruction);
		`Mips_Control_Signal_Register_Signal_Port1AddrSource_None : reg_rd1_addr$ = 5'b0;
		default                                                   : reg_rd1_addr$ = 5'b0;
	endcase
assign reg_rd1_addr = reg_rd1_addr$;

`Mips_Type_RegAddr_T (reg) reg_rd2_addr$;
always @(*)
	case(`Data_Array_Array_subRange(
		control,
		`Mips_Control_Control_Register_I +
		`Mips_Control_Signal_Register_Control_Port2AddrSource_I,
		`Mips_Control_Signal_Register_Control_Port2AddrSource_W
	))
		`Mips_Control_Signal_Register_Signal_Port2AddrSource_Rs   : reg_rd2_addr$ = `Mips_Instruction_Format_RFormat_Rs(instruction);
		`Mips_Control_Signal_Register_Signal_Port2AddrSource_Rt   : reg_rd2_addr$ = `Mips_Instruction_Format_RFormat_Rt(instruction);
		`Mips_Control_Signal_Register_Signal_Port2AddrSource_None : reg_rd2_addr$ = 5'b0;
		default                                                   : reg_rd2_addr$ = 5'b0;
	endcase
assign reg_rd2_addr = reg_rd2_addr$;

`Mips_Type_RegAddr_T (reg) reg_wr_addr$;
always @(*)
	case(`Data_Array_Array_subRange(
		control,
		`Mips_Control_Control_Register_I +
		`Mips_Control_Signal_Register_Control_WriteAddrSource_I,
		`Mips_Control_Signal_Register_Control_WriteAddrSource_W
	))
		`Mips_Control_Signal_Register_Signal_WriteAddrSource_Rd   : reg_wr_addr$ = `Mips_Instruction_Format_RFormat_Rd(instruction);
		`Mips_Control_Signal_Register_Signal_WriteAddrSource_Rt   : reg_wr_addr$ = `Mips_Instruction_Format_RFormat_Rt(instruction);
		`Mips_Control_Signal_Register_Signal_WriteAddrSource_R31  : reg_wr_addr$ = 5'd31;
		`Mips_Control_Signal_Register_Signal_WriteAddrSource_None : reg_wr_addr$ = 5'b0;
		default                                                   : reg_wr_addr$ = 5'b0;
	endcase
assign reg_wr_addr = reg_wr_addr$;

`Mips_Type_Word_T    (reg) reg_wr_data$;
always @(*)
	case(`Data_Array_Array_subRange(
		control,
		`Mips_Control_Control_Register_I +
		`Mips_Control_Signal_Register_Control_WriteDataSource_I,
		`Mips_Control_Signal_Register_Control_WriteDataSource_W
	))
		`Mips_Control_Signal_Register_Signal_WriteDataSource_Memory : reg_wr_data$ = ram_out;
		`Mips_Control_Signal_Register_Signal_WriteDataSource_Alu    : reg_wr_data$ = alu_result;
		`Mips_Control_Signal_Register_Signal_WriteDataSource_Pc     : reg_wr_data$ = pc_addr_curr + 4;
		default                                                     : reg_wr_data$ = alu_result;
	endcase
assign reg_wr_data = reg_wr_data$;

/*
Immediate
*/

`Mips_Type_Word_T (reg) immediate_extended ;
always @(*)
	case(`Data_Array_Array_subRange(
		control,
		`Mips_Control_Control_Immediate_I +
		`Mips_Control_Signal_Immediate_Control_Extend_I,
		`Mips_Control_Signal_Immediate_Control_Extend_W
	))
		`Mips_Control_Signal_Immediate_Signal_Extend_Unsigned : immediate_extended = {16'h0, `Mips_Instruction_Format_IFormat_Imm(instruction)};
		`Mips_Control_Signal_Immediate_Signal_Extend_Signed   : immediate_extended = {{16{instruction[16]}}, `Mips_Instruction_Format_IFormat_Imm(instruction)};
		default                                               : immediate_extended = {{16{instruction[16]}}, `Mips_Instruction_Format_IFormat_Imm(instruction)};
	endcase

`Mips_Type_Word_T (reg) immediate_extended_shifted ;
always @(*)
	case(`Data_Array_Array_subRange(
		control,
		`Mips_Control_Control_Immediate_I +
		`Mips_Control_Signal_Immediate_Control_Shift_I,
		`Mips_Control_Signal_Immediate_Control_Shift_W
	))
		`Mips_Control_Signal_Immediate_Signal_Shift_None   : immediate_extended_shifted = immediate_extended;
		`Mips_Control_Signal_Immediate_Signal_Shift_Left2  : immediate_extended_shifted = immediate_extended << 2;
		`Mips_Control_Signal_Immediate_Signal_Shift_Left16 : immediate_extended_shifted = immediate_extended << 16;
		default                                            : immediate_extended_shifted = immediate_extended;
	endcase

/*
Alu
*/

`Mips_Type_Word_T (reg) alu_data2$ ;
always @(*)
	case(`Data_Array_Array_subRange(
		control,
		`Mips_Control_Control_Alu_I +
		`Mips_Control_Signal_Alu_Control_Data2Source_I,
		`Mips_Control_Signal_Alu_Control_Data2Source_W
	))
		`Mips_Control_Signal_Alu_Signal_Data2Source_Register  : alu_data2$ = reg_rd2_data;
		`Mips_Control_Signal_Alu_Signal_Data2Source_Immediate : alu_data2$ = immediate_extended_shifted;
		`Mips_Control_Signal_Alu_Signal_Data2Source_Shamt     : alu_data2$ = {27'b0, `Mips_Instruction_Format_RFormat_Shamt(instruction)};
		default                                               : alu_data2$ = reg_rd2_data;
	endcase
assign alu_data2 = alu_data2$;

endmodule

`endif
