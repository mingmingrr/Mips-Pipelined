`include "Data/Control/Control.v"
`include "Mips/Type/Word.v"
`include "Mips/Type/RegAddr.v"
`include "Mips/Instruction/Format/RFormat.v"

`include "Mips/Control/Control.v"
`include "Mips/Control/Signal/Register/Control.v"

`include "Mips/Datapath/Register/wrAddr.v"
`include "Mips/Datapath/Register/wrData.v"
`include "Mips/Datapath/Register/register.v"

module Mips_Datapath_Register_datapath
	( `Data_Control_Control_T (input) ctrl
	, `Mips_Control_Control_T (input) writeControl
	, `Mips_Type_Word_T (input) readInstruction
	, `Mips_Type_Word_T (input) writeInstruction
	, `Mips_Type_Word_T (input) pcAddr
	, `Mips_Type_Word_T (input) memOut
	, `Mips_Type_Word_T (input) aluResult
	, `Mips_Type_Word_T (output) port1
	, `Mips_Type_Word_T (output) port2
	, output portEq
	);

`Mips_Control_Signal_Register_Control_T(wire) writeRegControl;
assign writeRegControl = `Mips_Control_Control_Register(writeControl);

`Mips_Type_RegAddr_T (wire) rd1Addr;
`Mips_Type_RegAddr_T (wire) rd2Addr;
assign rd1Addr = `Mips_Instruction_Format_RFormat_Rs(readInstruction);
assign rd2Addr = `Mips_Instruction_Format_RFormat_Rt(readInstruction);

`Mips_Type_RegAddr_T (wire) wrAddr;
Mips_Datapath_Register_wrAddr WRA
	( .control     (`Mips_Control_Signal_Register_Control_WriteAddrSource(writeRegControl))
	, .instruction (writeInstruction)
	, .wrAddr     (wrAddr)
	);

`Mips_Type_Word_T    (wire) wrData;
Mips_Datapath_Register_wrData WRD
	( .control   (`Mips_Control_Signal_Register_Control_WriteDataSource(writeRegControl))
	, .memOut    (memOut)
	, .pcAddr    (pcAddr)
	, .aluResult (aluResult)
	, .wrData    (wrData)
	);

Mips_Datapath_Register_register REG
	( .ctrl    (ctrl)
	, .rd1Addr (rd1Addr)
	, .rd2Addr (rd2Addr)
	, .wrAddr  (wrAddr)
	, .wrData  (wrData)
	, .wrEnable (`Mips_Control_Signal_Register_Control_WriteEnable(writeRegControl))
	, .rd1Data (port1)
	, .rd2Data (port2)
	);

assign portEq = port1 == port2;

endmodule
