`include "Mips/Type/Word.v"
`include "Mips/Type/RegAddr.v"
`include "Mips/Type/RegPorts.v"

`include "Mips/Control/Control.v"
`include "Mips/Control/Signal/Register/Control.v"

`include "Mips/Datapath/Register/rd1Addr.v"
`include "Mips/Datapath/Register/rd2Addr.v"
`include "Mips/Datapath/Register/wrAddr.v"

module Mips_Datapath_Register_ports
	( `Mips_Type_RegPorts_T (output) ports
	, `Mips_Control_Control_T (input) control
	, `Mips_Type_Word_T (input) instruction
	);

`Mips_Control_Signal_Register_Control_T(wire) regControl;
assign regControl = `Mips_Control_Control_Register(control);

`Mips_Type_RegAddr_T (wire) rd1Addr;
Mips_Datapath_Register_rd1Addr RD1A
	( .instruction (instruction)
	, .rd1Addr     (rd1Addr)
	);

`Mips_Type_RegAddr_T (wire) rd2Addr;
Mips_Datapath_Register_rd2Addr RD2A
	( .instruction (instruction)
	, .rd2Addr     (rd2Addr)
	);

`Mips_Type_RegAddr_T (wire) wrAddr;
Mips_Datapath_Register_wrAddr WRA
	( .control     (`Mips_Control_Signal_Register_Control_WriteAddrSource(regControl))
	, .instruction (instruction)
	, .wrAddr      (wrAddr)
	);

Mips_Type_RegPorts_pack PORTS
	( .read1Addr (rd1Addr)
	, .read2Addr (rd2Addr)
	, .writeAddr (wrAddr)
	, .writeData (`Mips_Control_Signal_Register_Control_WriteDataSource(regControl))
	, .writeEn (`Mips_Control_Signal_Register_Control_WriteEnable(regControl))
	, .out (ports)
	);

endmodule
