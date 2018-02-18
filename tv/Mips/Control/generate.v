`ifndef MIPS_CONTROL_GENERATE_I
`define MIPS_CONTROL_GENERATE_I

`include "../../Mips/Instruction/OpFunc/Source.v"
`include "../../Mips/Instruction/OpFunc/OpFunc.v"
`include "../../Mips/Instruction/Category.v"
`include "../../Mips/Instruction/categorize.v"
`include "../../Mips/Control/Control.v"

module Mips_Control_generate
	( `Mips_Instruction_OpFunc_OpFunc_T(input) opFunc
	, `Mips_Control_Control_T(output) control
	);

`Mips_Instruction_Category_T(wire) category;

Instruction_categorize GCAT
	( .opFunc (opFunc)
	, .category (category)
	);

`Mips_Control_Control_MemoryWriteEnable_T       (wire) memoryWriteEnable       ;
`Mips_Control_Control_RegisterWriteAddrSource_T (reg)  registerWriteAddrSource ;
`Mips_Control_Control_RegisterWriteDataSource_T (reg)  registerWriteDataSource ;
`Mips_Control_Control_Register1AddrSource_T     (reg)  register1AddrSource     ;
`Mips_Control_Control_RegisterWriteEnable_T     (reg)  registerWriteEnable     ;
`Mips_Control_Control_Register2AddrSource_T     (wire) register2AddrSource     ;
`Mips_Control_Control_PcAction_T                (reg)  pcAction                ;
`Mips_Control_Control_AluData2Source_T          (reg)  aluData2Source          ;
`Mips_Control_Control_ShamtSource_T             (reg)  shamtSource             ;

assign memoryWriteEnable = `Mips_Instruction_Category_Store(category);

always @(*)
	if(`Mips_Instruction_OpFunc_OpFunc_Source(opFunc)
			== `Mips_Instruction_OpFunc_Source_Func)
		registerWriteAddrSource = `Mips_Control_Signal_RegisterWriteAddrSource_Rd;
	else
		registerWriteAddrSource = `Mips_Control_Signal_RegisterWriteAddrSource_Rt;

always @(*)
	casez(category)
		`Mips_Instruction_Category_RJump_V:
			registerWriteEnable = 1'b0;
		`Mips_Instruction_Category_Jump_V:
			registerWriteEnable = 1'b0;
		`Mips_Instruction_Category_Branch_V:
			registerWriteEnable = 1'b0;
		default:
			registerWriteEnable = 1'b1;
	endcase

always @(*)
	casez(category)
		`Mips_Instruction_Category_Load_V:
			registerWriteDataSource = `Mips_Control_Signal_RegisterWriteDataSource_Memory;
		default:
			registerWriteDataSource = `Mips_Control_Signal_RegisterWriteDataSource_Alu;
	endcase

always @(*)
	casez(category)
		`Mips_Instruction_Category_RShift_V:
			register1AddrSource = `Mips_Control_Signal_Register1AddrSource_Rt;
		default:
			register1AddrSource = `Mips_Control_Signal_Register1AddrSource_Rs;
	endcase

assign register2AddrSource = `Mips_Control_Signal_Register2AddrSource_Rt;

always @(*)
	casez(category)
		`Mips_Instruction_Category_Jump_V:
			pcAction = `Mips_Pc_Action_Jump;
		`Mips_Instruction_Category_RJump_V:
			pcAction = `Mips_Pc_Action_Jump;
		`Mips_Instruction_Category_Branch_V:
			pcAction = `Mips_Pc_Action_Branch;
		default:
			pcAction = `Mips_Pc_Action_Inc;
	endcase

always @(*)
	if(`Mips_Instruction_OpFunc_OpFunc_Source(opFunc) == `Mips_Instruction_OpFunc_Source_Func)
		aluData2Source = `Mips_Control_Signal_AluData2Source_Register;
	else
		casez(category)
			`Mips_Instruction_Category_Branch_V:
				aluData2Source = `Mips_Control_Signal_AluData2Source_Register;
			`Mips_Instruction_Category_Logic_V:
				aluData2Source = `Mips_Control_Signal_AluData2Source_ImmediateUnsigned;
			default:
				aluData2Source = `Mips_Control_Signal_AluData2Source_ImmediateSigned;
		endcase

always @(*)
	casez(category)
		`Mips_Instruction_Category_RShift_V:
			shamtSource = `Mips_Control_Signal_ShamtSource_Shamt;
		default:
			if(opFunc == `Mips_Instruction_OpFunc_OpFuncs_Lui)
				shamtSource = `Mips_Control_Signal_ShamtSource_Const16;
			else
				shamtSource = `Mips_Control_Signal_ShamtSource_None;
		endcase

assign control = `Mips_Control_Control_Init_Defaults;

endmodule

`endif

