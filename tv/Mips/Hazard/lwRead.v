`include "Mips/Type/Bool.v"
`include "Mips/Type/RegAddr.v"
`include "Mips/Control/Signal/Register/Signal/WriteDataSource.v"

module Mips_Hazard_lwRead
	( `Mips_Type_Bool_T (output) stallLwRead
	, `Mips_Type_RegAddr_T (input) regRead1Addr
	, `Mips_Type_RegAddr_T (input) regRead2Addr
	, `Mips_Type_RegAddr_T (input) exWriteAddr
	, `Mips_Control_Signal_Register_Signal_WriteDataSource_T (input) exWriteData
	);

assign stallLwRead =
	exWriteData == `Mips_Control_Signal_Register_Signal_WriteDataSource_Memory &&
	(|exWriteAddr) &&
	(
		exWriteAddr == regRead1Addr ||
		exWriteAddr == regRead2Addr
	);

endmodule
