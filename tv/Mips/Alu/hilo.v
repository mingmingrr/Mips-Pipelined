`ifndef ALU_HILO_I
`define ALU_HILO_I

`include "Util/Math.v"
`include "Mips/Alu/Func.v"
`include "Mips/Alu/Status.v"
`include "Mips/Alu/alu.v"
`include "Data/Control/Control.v"
`include "Util/Delay/arr.v"

`define Mips_Alu_hilo_Type_Data_T(T) T [DATA_W-1:0]
`define Mips_Alu_hilo_Type_Shamt_T(T) T [SHAMT_W-1:0]

module Mips_Alu_hilo #
	( parameter DATA_W  = 32
	, parameter SHAMT_W = Util_Math_log2(DATA_W)
	, parameter DELAY   = 0
	)
	( `Data_Control_Control_T             (input) ctrl
	, `Mips_Alu_hilo_Type_Data_T  (input) data1
	, `Mips_Alu_hilo_Type_Data_T  (input) data2
	, `Mips_Alu_Func_T            (input) func
	, `Mips_Alu_hilo_Type_Data_T  (output) result
	, `Mips_Alu_Status_T          (output) status
	);

`Util_Math_log2_expr

`Mips_Alu_hilo_Type_Data_T (reg)  reg_hi, reg_lo;
`Mips_Alu_hilo_Type_Data_T (wire) res_hi, res_lo;
`Mips_Alu_Status_T         (wire) status$;

Mips_Alu_alu #
	( .DATA_W  (DATA_W)
	) GALU
	( .data1  (data1)
	, .data2  (data2)
	, .func   (func)
	, .reg_lo (reg_lo)
	, .reg_hi (reg_hi)
	, .res_lo (res_lo)
	, .res_hi (res_hi)
	, .status (status$)
	);

reg store_hi, store_lo;
always @(*)
	case(func)
		`Mips_Alu_Func_Mulu : {store_hi, store_lo} = 2'b11;
		`Mips_Alu_Func_Muls : {store_hi, store_lo} = 2'b11;
		`Mips_Alu_Func_Divu : {store_hi, store_lo} = 2'b11;
		`Mips_Alu_Func_Divs : {store_hi, store_lo} = 2'b11;
		`Mips_Alu_Func_Mthi : {store_hi, store_lo} = 2'b10;
		`Mips_Alu_Func_Mtlo : {store_hi, store_lo} = 2'b01;
		default             : {store_hi, store_lo} = 2'b00;
	endcase

always @(posedge `Data_Control_Control_Clock(ctrl))
	if(`Data_Control_Control_Reset(ctrl))
		reg_hi <= DATA_W'(0);
	else if(store_hi)
		reg_hi <= res_hi;

always @(posedge `Data_Control_Control_Clock(ctrl))
	if(`Data_Control_Control_Reset(ctrl))
		reg_lo <= DATA_W'(0);
	else if(store_lo)
		reg_lo <= res_lo;

Util_Delay_arr #
	( .DELAY (DELAY)
	, .WIDTH (DATA_W)
	) DELAYRESULT
	( .in   (res_lo)
	, .out  (result)
	, .ctrl (ctrl)
	);
Util_Delay_arr #
	( .DELAY (DELAY)
	, .WIDTH (`Mips_Alu_Status_W)
	) DELAYSTATUS
	( .in   (status$)
	, .out  (status)
	, .ctrl (ctrl)
	);

endmodule

`undef Mips_Alu_hilo_Type_Data_T
`undef Mips_Alu_hilo_Type_Shamt_T

`endif

