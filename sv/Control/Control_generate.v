`ifndef CONTROL_GENERATE_I
`define CONTROL_GENERATE_I

`include "../Opcode/Opcode_Source.v"
`include "../Opcode/Opcode_OpFunc.v"
`include "../Control/Control_Control.v"
`include "../Instruction/Instruction_Category.v"

module Control_generate
	( `Opcode_OpFunc_T(input)        opFunc
	, `Instruction_Category_T(input) category
	, `Control_Control_T(output)     control
	);

`Control_Control_MemoryWriteEnable_T       (wire) memoryWriteEnable       ;
`Control_Control_RegisterWriteAddrSource_T (reg)  registerWriteAddrSource ;
`Control_Control_RegisterWriteDataSource_T (reg)  registerWriteDataSource ;
`Control_Control_Register1AddrSource_T     (reg)  register1AddrSource     ;
`Control_Control_Register2AddrSource_T     (reg)  register2AddrSource     ;
`Control_Control_PcAction_T                (reg)  pcAction                ;
`Control_Control_AluData2Source_T          (reg)  aluData2Source          ;
`Control_Control_ShamtSource_T             (reg)  shamtSource             ;

assign memoryWriteEnable = `Instruction_Category_Store(category);

always @(*)
	if(`Opcode_OpFunc_Source(opFunc) == `Opcode_Source_Func)
		casez(category)
			`Instruction_Category_RJump_V:
				registerWriteAddrSource = `Control_RegisterWriteAddrSource_None;
			default:
				registerWriteAddrSource = `Control_RegisterWriteAddrSource_Rd;
		endcase
	else
		casez(category)
			`Instruction_Category_Branch_V:
				registerWriteAddrSource = `Control_RegisterWriteAddrSource_None;
			`Instruction_Category_Jump_V:
				registerWriteAddrSource = `Control_RegisterWriteAddrSource_None;
			default:
				registerWriteAddrSource = `Control_RegisterWriteAddrSource_Rt;
		endcase

always @(*)
	casez(category)
		`Instruction_Category_Load_V:
			registerWriteDataSource = `Control_RegisterWriteDataSource_Memory;
		default:
			registerWriteDataSource = `Control_RegisterWriteDataSource_Alu;
	endcase

always @(*)
	casez(category)
		`Instruction_Category_RShift_V:
			register1AddrSource = `Control_Register1AddrSource_Rt;
		default:
			register1AddrSource = `Control_Register1AddrSource_Rs;
	endcase

always @(*)
	register2AddrSource = `Control_Register2AddrSource_Rt;

always @(*)
	casez(category)
		`Instruction_Category_Jump_V:
			pcAction = `Pc_Action_Jump;
		`Instruction_Category_RJump_V:
			pcAction = `Pc_Action_Jump;
		`Instruction_Category_Branch_V:
			pcAction = `Pc_Action_Branch;
		default:
			pcAction = `Pc_Action_Inc;
	endcase

always @(*)
	if(`Opcode_OpFunc_Source(opFunc) == `Opcode_Source_Func)
		aluData2Source = `Control_AluData2Source_Register;
	else
		casez(category)
			`Instruction_Category_Branch_V:
				aluData2Source = `Control_AluData2Source_Register;
			`Instruction_Category_Logic_V:
				aluData2Source = `Control_AluData2Source_ImmediateUnsigned;
			default:
				aluData2Source = `Control_AluData2Source_ImmediateSigned;
		endcase

always @(*)
	casez(category)
		`Instruction_Category_RShift_V:
			shamtSource = `Control_ShamtSource_Shamt;
		default:
			if(opFunc == `Opcode_OpFunc_Lui)
				shamtSource = `Control_ShamtSource_Const16;
			else
				shamtSource = `Control_ShamtSource_None;
		endcase

assign control = `Control_Control_Init_Defaults;

endmodule

`endif

