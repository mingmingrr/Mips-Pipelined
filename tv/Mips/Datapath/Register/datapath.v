`include "Data/Control/Control.v"

`include "Mips/Type/Word.v"
`include "Mips/Type/RegAddr.v"
`include "Mips/Type/RegPorts.v"
`include "Mips/Instruction/Format/RFormat.v"

`include "Mips/Control/Control.v"
`include "Mips/Control/Signal/Register/Control.v"

`include "Mips/Datapath/Register/ports.v"
`include "Mips/Datapath/Register/wrData.v"
`include "Mips/Datapath/Register/register.v"

module Mips_Datapath_Register_datapath #
	( parameter PASSTHROUGH = 0
	)
	( `Data_Control_Control_T (input) ctrl
	, `Mips_Control_Control_T (input) control
	, `Mips_Type_RegPorts_T (input)  portsIn
	, `Mips_Type_RegPorts_T (output) portsOut
	, `Mips_Type_Word_T (input) instruction
	, `Mips_Type_Word_T (input) pcAddr
	, `Mips_Type_Word_T (input) memOut
	, `Mips_Type_Word_T (input) aluResult
	, `Mips_Type_Word_T (output) writeData
	, `Mips_Type_Word_T (output) port1
	, `Mips_Type_Word_T (output) port2
	, output portEq
	);

`Mips_Type_Bool_T (wire) portIn_WriteEn;
`Mips_Type_RegAddr_T (wire) portIn_WriteAddr;
`Mips_Control_Signal_Register_Signal_WriteDataSource_T (wire) portIn_WriteData;
Mips_Type_RegPorts_unpack PORTIN
	( .in (portsIn)
	, .read1Addr ()
	, .read2Addr ()
	, .writeAddr (portIn_WriteAddr)
	, .writeData (portIn_WriteData)
	, .writeEn (portIn_WriteEn)
	);

Mips_Datapath_Register_ports PORTS
	( .ports (portsOut)
	, .control (control)
	, .instruction (instruction)
	);

`Mips_Type_RegAddr_T (wire) portOut_Read1Addr;
`Mips_Type_RegAddr_T (wire) portOut_Read2Addr;
Mips_Type_RegPorts_unpack PORTOUT
	( .in (portsOut)
	, .read1Addr (portOut_Read1Addr)
	, .read2Addr (portOut_Read2Addr)
	, .writeAddr ()
	, .writeData ()
	, .writeEn ()
	);

`Mips_Type_Word_T (wire) wrData;
Mips_Datapath_Register_wrData WRD
	( .source    (portIn_WriteData)
	, .memOut    (memOut)
	, .pcAddr    (pcAddr)
	, .aluResult (aluResult)
	, .wrData    (wrData)
	);

Mips_Datapath_Register_register #
	( .PASSTHROUGH (PASSTHROUGH)
	) REG
	( .ctrl    (ctrl)
	, .rd1Addr (portOut_Read1Addr)
	, .rd2Addr (portOut_Read2Addr)
	, .wrData   (wrData)
	, .wrAddr   (portIn_WriteAddr)
	, .wrEnable (portIn_WriteEn)
	, .rd1Data (port1)
	, .rd2Data (port2)
	);

assign portEq = port1 == port2;
assign writeData = wrData;

endmodule
