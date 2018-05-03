`include "Mips/Control/Signal/Register/Signal/WriteDataSource.v"
`include "Mips/Type/RegPorts.v"
`include "Mips/Type/Bool.v"

`include "Mips/Hazard/lwRead.v"

module Mips_Hazard_hazard
	( `Mips_Type_Bool_T (output) stallLwRead
	, `Mips_Type_RegAddr_T (input) regRead1Addr
	, `Mips_Type_RegAddr_T (input) regRead2Addr
	, `Mips_Type_RegAddr_T (input) exWriteAddr
	, `Mips_Control_Signal_Register_Signal_WriteDataSource_T (input) exWriteData
	);

Mips_Hazard_lwRead LWREAD
	( .stallLwRead (stallLwRead)
	, .regRead1Addr (regRead1Addr)
	, .regRead2Addr (regRead2Addr)
	, .exWriteData (exWriteData)
	, .exWriteAddr (exWriteAddr)
	);

endmodule
