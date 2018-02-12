// vim: set ft=verilog:

`ifndef ALU_HILO_I
`define ALU_HILO_I

`include "../Util/Util_Math.v"
`include "../Alu/Alu_Func.v"
`include "../Util/Util_Control.v"

module Alu_hilo #
	( parameter DATA_W  = 32
	, parameter SHAMT_W = Util_Math_log2(DATA_W)
	, parameter DELAY   = 0
	)
	( `Util_Control_T(input) ctrl
	, input  [DATA_W-1:0]    data1
	, input  [DATA_W-1:0]    data2
	, `Alu_Func_T(input)     func
	, input  [SHAMT_W-1:0]   shamt
	, output [DATA_W-1:0]    result
	, output                 zero
	);

`Util_Math_log2_expr

reg [DATA_W-1:0] reg_hi, reg_lo;
wire [DATA_W-1:0] res_hi, res_lo;
wire zero$;
Alu_alu #
	( .DATA_W  (DATA_W)
	, .SHAMT_W (SHAMT_W)
	) a
	( .data1  (data1)
	, .data2  (data2)
	, .func   (func)
	, .shamt  (shamt)
	, .reg_lo (reg_lo)
	, .reg_hi (reg_hi)
	, .res_lo (res_lo)
	, .res_hi (res_hi)
	, .zero   (zero$)
	);

reg store_hi, store_lo;
always @(*)
	case(func)
		`Alu_Func_Mulu : {store_hi, store_lo} <= 2'b11;
		`Alu_Func_Muls : {store_hi, store_lo} <= 2'b11;
		`Alu_Func_Divu : {store_hi, store_lo} <= 2'b11;
		`Alu_Func_Divs : {store_hi, store_lo} <= 2'b11;
		`Alu_Func_Mthi : {store_hi, store_lo} <= 2'b10;
		`Alu_Func_Mtlo : {store_hi, store_lo} <= 2'b01;
		default        : {store_hi, store_lo} <= 2'b00;
	endcase

always @(posedge `Util_Control_clock(ctrl))
	if(`Util_Control_reset(ctrl))
		reg_hi <= DATA_W'(0);
	else if(store_hi)
		reg_hi <= res_hi;

always @(posedge `Util_Control_clock(ctrl))
	if(`Util_Control_reset(ctrl))
		reg_lo <= DATA_W'(0);
	else if(store_lo)
		reg_lo <= res_lo;

Delay_arr #
	( .DELAY (DELAY)
	, .WIDTH (DATA_W)
	) dres
	( .in   (res_lo)
	, .out  (result)
	, .ctrl (ctrl)
	);
Delay_gen #
	( .DELAY (DELAY)
	) dzero
	( .in   (zero$)
	, .out  (zero)
	, .ctrl (ctrl)
	);

endmodule

`endif

