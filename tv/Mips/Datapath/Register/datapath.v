`include "Data/Control/Control.v"
`include "Mips/Type/Word.v"
`include "Mips/Type/RegAddr.v"
`include "Mips/Instruction/Format/RFormat.v"

`include "Mips/Control/Control.v"
`include "Mips/Control/Signal/Register/Control.v"

`include "Mips/Datapath/Register/rd1Addr.v"
`include "Mips/Datapath/Register/rd2Addr.v"
`include "Mips/Datapath/Register/wrAddr.v"
`include "Mips/Datapath/Register/wrData.v"
`include "Mips/Datapath/Register/register.v"

module Mips_Datapath_Register_datapath
	( `Data_Control_Control_T (input) ctrl
	, `Mips_Control_Control_T (input) control
	, `Mips_Type_Word_T (input) instruction
	, `Mips_Type_Word_T (input) pcAddr
	, `Mips_Type_Word_T (input) memOut
	, `Mips_Type_Word_T (input) aluResult
	, `Mips_Type_Word_T (output) port1
	, `Mips_Type_Word_T (output) port2
	, output portEq
	);

`Mips_Control_Signal_Register_Control_T(wire) regControl;
assign regControl = `Mips_Control_Control_Register(control);

`Mips_Type_RegAddr_T (wire) rd1Addr;
Mips_Datapath_Register_rd1Addr RD1
	( .control     (`Mips_Control_Signal_Register_Control_Port1AddrSource(regControl))
	, .instruction (instruction)
	, .rd1Addr     (rd1Addr)
	);

`Mips_Type_RegAddr_T (wire) rd2Addr;
Mips_Datapath_Register_rd2Addr RD2
	( .control     (`Mips_Control_Signal_Register_Control_Port2AddrSource(regControl))
	, .instruction (instruction)
	, .rd2Addr     (rd2Addr)
	);

`Mips_Type_RegAddr_T (wire) wrAddr;
Mips_Datapath_Register_wrAddr WRA
	( .control     (`Mips_Control_Signal_Register_Control_WriteAddrSource(regControl))
	, .instruction (instruction)
	, .wrAddr     (wrAddr)
	);

`Mips_Type_Word_T    (wire) wrData;
Mips_Datapath_Register_wrData WRD
	( .control   (`Mips_Control_Signal_Register_Control_WriteDataSource(regControl))
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
	, .wrEnable (`Mips_Control_Signal_Register_Control_WriteEnable(regControl))
	, .rd1Data (port1)
	, .rd2Data (port2)
	);

assign portEq = port1 == port2;

endmodule
