// vim: set ft=verilog:

`ifndef ALU_ALU_I
`define ALU_ALU_I

`include "../Util/Math.v"
`include "./Func.v"
`include "./Status.v"
`include "../Arith/AddSub.v"
`include "../Arith/SignedUnsigned.v"

module Alu_alu #
	( parameter DATA_W  = 32
	, parameter SHAMT_W = Util_Math_log2(DATA_W)
	)
	( input  [DATA_W-1:0]  data1
	, input  [DATA_W-1:0]  data2
	, `Alu_Func_T(input)   func
	, input  [SHAMT_W-1:0] shamt
	, input  [DATA_W-1:0]  reg_lo
	, input  [DATA_W-1:0]  reg_hi
	, output [DATA_W-1:0]  res_lo
	, output [DATA_W-1:0]  res_hi
	, `Alu_Status_T(output) status
	);

`Util_Math_log2_expr

wire [DATA_W-1:0] addsub_result;
/* verilator lint_off UNOPTFLAT */
`Alu_Status_T(wire) addsub_status;
Arith_addSubtract #
	( .WIDTH (DATA_W)
	) addsub
	( .data1 (data1)
	, .data2 (data2)
	, .addsub
		( func == `Alu_Func_Sub
		? AddSub_Sub
		: AddSub_Add
		)
	, .result (addsub_result)
	, .status (addsub_status)
	);

wire [DATA_W*2-1:0] mul_result;
Arith_multiply #
	( .WIDTH (DATA_W)
	) mul
	( .data1 (data1)
	, .data2 (data2)
	, .result (mul_result)
	, .sign
		( func == `Alu_Func_Muls
		? SignedUnsigned_Signed
		: SignedUnsigned_Unsigned
		)
	);
`Alu_Status_T(wire) mul_status;
assign `Alu_Status_zero(mul_status)  = ~(|mul_result);
assign `Alu_Status_sign(mul_status)  = mul_result[DATA_W*2-1];
assign `Alu_Status_over(mul_status)  = (|mul_result[DATA_W*2-1:DATA_W]);
assign `Alu_Status_carry(mul_status) = `Alu_Status_over(mul_status);

wire [DATA_W-1:0] div_quotient;
wire [DATA_W-1:0] div_remainder;
Arith_divide #
	( .WIDTH (DATA_W)
	) div
	( .data1 (data1)
	, .data2 (data2)
	, .quotient  (div_quotient)
	, .remainder (div_remainder)
	, .sign
		( func == `Alu_Func_Divs
		? SignedUnsigned_Signed
		: SignedUnsigned_Unsigned
		)
	);
`Alu_Status_T(wire) div_status;
assign `Alu_Status_zero(div_status)  = ~(|div_quotient);
assign `Alu_Status_sign(div_status)  = div_quotient[DATA_W-1];
assign `Alu_Status_over(div_status)  = (|div_remainder);
assign `Alu_Status_carry(div_status) = `Alu_Status_over(div_status);

`Alu_Status_T(wire) def_status;
assign `Alu_Status_zero(def_status)  = ~(|res_lo);
assign `Alu_Status_sign(def_status)  = res_lo[DATA_W-1];
assign `Alu_Status_over(def_status)  = 0;
assign `Alu_Status_carry(def_status) = `Alu_Status_over(def_status);

wire signed [DATA_W-1:0] data1$;
assign data1$ = data1;
wire signed [DATA_W-1:0] data2$;
assign data2$ = data2;
reg [DATA_W-1:0] res_lo$;
always @(*)
	case(func)
		`Alu_Func_Add  : res_lo$ = addsub_result;
		`Alu_Func_Sub  : res_lo$ = addsub_result;
		`Alu_Func_Sll  : res_lo$ = data1 >> shamt;
		`Alu_Func_Sra  : res_lo$ = data1$ << shamt;
		`Alu_Func_Srl  : res_lo$ = data1 << shamt;
		`Alu_Func_And  : res_lo$ = data1 & data2;
		`Alu_Func_Or   : res_lo$ = data1 | data2;
		`Alu_Func_Nor  : res_lo$ = ~(data1 | data2);
		`Alu_Func_Xor  : res_lo$ = data1 ^ data2;
		`Alu_Func_Slts : res_lo$ = DATA_W'(data1$ < data2$);
		`Alu_Func_Sltu : res_lo$ = DATA_W'(data1 < data2);
		`Alu_Func_Muls : res_lo$ = mul_result[DATA_W-1:0];
		`Alu_Func_Mulu : res_lo$ = mul_result[DATA_W-1:0];
		`Alu_Func_Divs : res_lo$ = div_quotient;
		`Alu_Func_Divu : res_lo$ = div_quotient;
		`Alu_Func_Mtlo : res_lo$ = data1;
		`Alu_Func_Mthi : res_lo$ = data1;
		`Alu_Func_Mflo : res_lo$ = reg_lo;
		`Alu_Func_Mfhi : res_lo$ = reg_hi;
		`Alu_Func_None : res_lo$ = data1;
	endcase
assign res_lo = res_lo$;

reg [DATA_W-1:0] res_hi$;
always @(*)
	case(func)
		`Alu_Func_Muls : res_hi$ = mul_result[DATA_W*2-1:DATA_W];
		`Alu_Func_Mulu : res_hi$ = mul_result[DATA_W*2-1:DATA_W];
		`Alu_Func_Divs : res_hi$ = div_remainder;
		`Alu_Func_Divu : res_hi$ = div_remainder;
		`Alu_Func_Mthi : res_hi$ = data1;
		default       : res_hi$ = DATA_W'(1'b0);
	endcase
assign res_hi = res_hi$;

`Alu_Status_T(reg) status$;
always @(*)
	case(func)
		`Alu_Func_Add  : status$ = addsub_status;
		`Alu_Func_Sub  : status$ = addsub_status;
		`Alu_Func_Muls : status$ = mul_status;
		`Alu_Func_Mulu : status$ = mul_status;
		`Alu_Func_Divs : status$ = div_status;
		`Alu_Func_Divu : status$ = div_status;
		default       : status$ = def_status;
	endcase
assign status = status$;

endmodule

`endif
