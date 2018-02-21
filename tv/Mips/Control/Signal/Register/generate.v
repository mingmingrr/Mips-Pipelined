`ifndef MIPS_CONTROL_SIGNAL_REGISTER_GENERATE_I
`define MIPS_CONTROL_SIGNAL_REGISTER_GENERATE_I

`include "Mips/Instruction/Category/Category.v"
`include "Mips/Instruction/OpFunc/OpFunc.v"
`include "Mips/Control/Signal/Register/Control.v"

module Mips_Control_Signal_Register_generate
	( `Mips_Instruction_OpFunc_OpFunc_T       (input)  opFunc
	, `Mips_Instruction_Category_Category_T   (input)  category
	, `Mips_Control_Signal_Register_Control_T (output) control
	);

`Mips_Control_Signal_Register_Control_Port1AddrSource_T (reg)  port1AddrSource ;
`Mips_Control_Signal_Register_Control_Port2AddrSource_T (wire) port2AddrSource ;
`Mips_Control_Signal_Register_Control_WriteAddrSource_T (reg)  writeAddrSource ;
`Mips_Control_Signal_Register_Control_WriteDataSource_T (reg)  writeDataSource ;
`Mips_Control_Signal_Register_Control_WriteEnable_T     (reg)  writeEnable     ;

always @(*)
	if(
		`Mips_Instruction_Category_Category_Shift(category) &&
		`Mips_Instruction_Category_Category_Register(category)
	)
		port1AddrSource = `Mips_Control_Signal_Register_Signal_Port1AddrSource_Rt ;
	else
		port1AddrSource = `Mips_Control_Signal_Register_Signal_Port1AddrSource_Rs ;

assign
	port2AddrSource = `Mips_Control_Signal_Register_Signal_Port2AddrSource_Rt;

always @(*)
	if(`Mips_Instruction_Category_Category_Link(category))
		writeAddrSource = `Mips_Control_Signal_Register_Signal_WriteAddrSource_R31;
	else if(`Mips_Instruction_OpFunc_OpFunc_Source(opFunc) == `Mips_Instruction_OpFunc_Source_Func)
		writeAddrSource = `Mips_Control_Signal_Register_Signal_WriteAddrSource_Rd;
	else
		writeAddrSource = `Mips_Control_Signal_Register_Signal_WriteAddrSource_Rt;

always @(*)
	if(`Mips_Instruction_Category_Category_Load(category))
		writeDataSource = `Mips_Control_Signal_Register_Signal_WriteDataSource_Memory ;
	else
		writeDataSource = `Mips_Control_Signal_Register_Signal_WriteDataSource_Alu    ;

always @(*)
	if(
		`Mips_Instruction_Category_Category_Jump(category) ||
		`Mips_Instruction_Category_Category_Branch(category) ||
		`Mips_Instruction_Category_Category_Store(category)
	)
		writeEnable = `Mips_Control_Signal_Register_Signal_WriteEnable_False ;
	else
		writeEnable = `Mips_Control_Signal_Register_Signal_WriteEnable_True  ;

assign control = `Mips_Control_Signal_Register_Control_Init_Defaults;

endmodule

`endif

