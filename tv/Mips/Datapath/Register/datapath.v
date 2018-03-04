`include "Data/Control/Control.v"
`include "Mips/Type/Word.v"
`include "Mips/Type/RegAddr.v"
`include "Mips/Instruction/Format/RFormat.v"
`include "Mips/Control/Signal/Register/Control.v"
`include "Mips/Control/Signal/Register/Signal/Port1AddrSource.v"
`include "Mips/Control/Signal/Register/Signal/Port2AddrSource.v"
`include "Mips/Control/Signal/Register/Signal/WriteAddrSource.v"
`include "Mips/Control/Signal/Register/Signal/WriteDataSource.v"
`include "Mips/Control/Signal/Register/Signal/WriteEnable.v"

`include "Mips/Datapath/Register/register.v"

module Mips_Datapath_Register_datapath
	( `Data_Control_Control_T (input) ctrl
	, `Mips_Control_Signal_Register_Control_T(input) control
	, `Mips_Type_Word_T(input) pcAddr
	, `Mips_Type_Word_T(input) ramOut
	, `Mips_Type_Word_T(input) aluResult
	, `Mips_Type_Word_T(input) instruction
	, `Mips_Type_Word_T(output) port1
	, `Mips_Type_Word_T(output) port2
	);

`Mips_Type_RegAddr_T (wire) rd1Addr ;
`Mips_Type_Word_T    (wire) rd1Data ;
`Mips_Type_RegAddr_T (wire) rd2Addr ;
`Mips_Type_Word_T    (wire) rd2Data ;
`Mips_Type_RegAddr_T (wire) wrAddr  ;
`Mips_Type_Word_T    (wire) wrData  ;
Mips_Datapath_Register_register REG
	( .ctrl    (ctrl)
	, .rd1Addr (rd1Addr)
	, .rd1Data (rd1Data)
	, .rd2Addr (rd2Addr)
	, .rd2Data (rd2Data)
	, .wrAddr  (wrAddr )
	, .wrData  (wrData )
	, .wrEnable (`Mips_Control_Signal_Register_Control_WriteEnable(control))
	);

`Mips_Type_RegAddr_T (wire) rs;
`Mips_Type_RegAddr_T (wire) rt;
`Mips_Type_RegAddr_T (wire) rd;
assign rs = `Mips_Instruction_Format_RFormat_Rs(instruction);
assign rd = `Mips_Instruction_Format_RFormat_Rd(instruction);
assign rt = `Mips_Instruction_Format_RFormat_Rt(instruction);

`Mips_Type_RegAddr_T (reg) rd1Addr$;
always @(*)
	case(`Mips_Control_Signal_Register_Control_Port1AddrSource(control))
		`Mips_Control_Signal_Register_Signal_Port1AddrSource_Rs   : rd1Addr$ = rs;
		`Mips_Control_Signal_Register_Signal_Port1AddrSource_Rt   : rd1Addr$ = rt;
		`Mips_Control_Signal_Register_Signal_Port1AddrSource_None : rd1Addr$ = 5'b0;
		default                                                        : rd1Addr$ = 5'b0;
	endcase
assign rd1Addr = rd1Addr$;

`Mips_Type_RegAddr_T (reg) rd2Addr$;
always @(*)
	case(`Mips_Control_Signal_Register_Control_Port2AddrSource(control))
		`Mips_Control_Signal_Register_Signal_Port2AddrSource_Rs   : rd2Addr$ = rs;
		`Mips_Control_Signal_Register_Signal_Port2AddrSource_Rt   : rd2Addr$ = rt;
		`Mips_Control_Signal_Register_Signal_Port2AddrSource_None : rd2Addr$ = 5'b0;
		default                                                        : rd2Addr$ = 5'b0;
	endcase
assign rd2Addr = rd2Addr$;

`Mips_Type_RegAddr_T (reg) wrAddr$;
always @(*)
	case(`Mips_Control_Signal_Register_Control_WriteAddrSource(control))
		`Mips_Control_Signal_Register_Signal_WriteAddrSource_Rd   : wrAddr$ = rd;
		`Mips_Control_Signal_Register_Signal_WriteAddrSource_Rt   : wrAddr$ = rt;
		`Mips_Control_Signal_Register_Signal_WriteAddrSource_R31  : wrAddr$ = 5'd31;
		`Mips_Control_Signal_Register_Signal_WriteAddrSource_None : wrAddr$ = 5'b0;
		default                                                        : wrAddr$ = 5'b0;
	endcase
assign wrAddr = wrAddr$;

`Mips_Type_Word_T (reg) wrData$;
always @(*)
	case(`Mips_Control_Signal_Register_Control_WriteDataSource(control))
		`Mips_Control_Signal_Register_Signal_WriteDataSource_Memory : wrData$ = ramOut;
		`Mips_Control_Signal_Register_Signal_WriteDataSource_Pc     : wrData$ = pcAddr + 4;
		`Mips_Control_Signal_Register_Signal_WriteDataSource_Alu    : wrData$ = aluResult;
		default                                                          : wrData$ = aluResult;
	endcase
assign wrData = wrData$;

assign port1 = rd1Data;
assign port2 = rd2Data;

endmodule
