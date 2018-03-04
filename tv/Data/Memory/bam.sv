`include "Altera/Mf.v"
`include "Util/Math.v"
`include "Data/Control/Control.v"

`include "Data/Memory/bam.v"

module Data_Memory_bam_tb;

`Data_Control_Control_T(logic) ctrl;
logic [3:0] addr;
logic [31:0] data;
logic [3:0] bytes;
logic [31:0] out;
logic wren;

Data_Memory_bam #
	( .DATA_W (32)
	, .BYTE_W (8)
	, .ADDR_WORD_L (4)
	) DUT
	( .ctrl (ctrl)
	, .addr (addr)
	, .data (data)
	, .bytes (bytes)
	, .out (out)
	, .wren (wren)
	);

initial `Data_Control_Control_Clock(ctrl) = 1'b0;
always #5 `Data_Control_Control_Clock(ctrl) = !`Data_Control_Control_Clock(ctrl);

initial begin
	#0;
	`Data_Control_Control_Reset(ctrl) = 1'b1;

	#10;
	`Data_Control_Control_Reset(ctrl) = 1'b0;
	addr = 4'h4;
	data = 32'h01234567;
	bytes = 4'b1111;
	wren = 1'b1;

	#10;
	addr = 4'h0;
	data = 32'h89abcdef;
	bytes = 4'b1111;
	wren = 1'b1;

	#10;
	bytes = 4'b1111;
	wren = 1'b0;

	#10;
	bytes = 4'b1001;
	wren = 1'b0;

	#10;
	addr = 4'h2;
	bytes = 4'b0011;
	wren = 1'b0;

	#10;
	addr = 4'h1;
	data = 32'h76543210;
	bytes = 4'b1001;
	wren = 1'b1;
end

endmodule

