`include "Altera/Mf.v"
`include "Util/Math.v"
`include "Data/Control/Control.v"

// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on

module Data_Memory_bam #
	( parameter DATA_W = 32
	, parameter BYTE_W = 8
	, parameter BYTE_L = (DATA_W - 1) / BYTE_W + 1
	, parameter OFFSET_W = Util_Math_log2(BYTE_L)
	, parameter ADDR_WORD_L = 64
	, parameter ADDR_WORD_W = Util_Math_log2(ADDR_WORD_L)
	, parameter ADDR_BYTE_L = ADDR_WORD_L * BYTE_L
	, parameter ADDR_BYTE_W = Util_Math_log2(ADDR_BYTE_L)
	)
	( `Data_Control_Control_T(input) ctrl
	, input  [ADDR_BYTE_W-1:0] addr
	, input  [DATA_W-1:0] data
	, input  [BYTE_L-1:0] bytes
	, output [DATA_W-1:0] out
	, input wren
	);

`Util_Math_log2_expr

wire [ADDR_WORD_W-1:0] addr_a;
wire [ADDR_WORD_W-1:0] addr_b;
wire [OFFSET_W-1:0] offset;
reg [OFFSET_W-1:0] offset$;
wire [DATA_W-1:0] data_a;
wire [DATA_W-1:0] data_b;
wire [DATA_W-1:0] out_a;
wire [DATA_W-1:0] out_b;
wire [2*DATA_W-1:0] data_bytes [BYTE_L-1:0];
wire [2*DATA_W-1:0] out_bytes [BYTE_L-1:0];
wire [BYTE_L-1:0] byteen_a;
wire [BYTE_L-1:0] byteen_b;

`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
// 	tri1 [BYTE_L-1:0] bytee_a;
// 	tri1 [BYTE_L-1:0] bytee_b;
// 	tri1 clock;
// 	tri0 wren_a;
// 	tri0 wren_b;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

assign {addr_a, offset} = addr;
assign addr_b = addr_a + 1;
assign {byteen_b, byteen_a} = {BYTE_L'(0), bytes} << offset;
always @(posedge `Data_Control_Control_Clock(ctrl)) offset$ = offset;

genvar i;
generate for(i = 0; i < BYTE_L; i = i + 1) begin : gv
	assign data_bytes[i] = {DATA_W'(0), data} << (BYTE_W * i);
	assign out_bytes[i] = ({out_b, out_a} >> (BYTE_W * i));
end endgenerate

assign out = out_bytes[offset$][DATA_W-1:0];
assign {data_b, data_a} = data_bytes[offset];

altsyncram altsyncram_component
	( .clock0         (`Data_Control_Control_Clock(ctrl))
	, .address_a      (addr_a)
	, .address_b      (addr_b)
	, .byteena_a      (byteen_a)
	, .byteena_b      (byteen_b)
	, .data_a         (data_a)
	, .data_b         (data_b)
	, .wren_a         (wren)
	, .wren_b         (wren)
	, .q_a            (out_a)
	, .q_b            (out_b)
	, .aclr0          (1'b0)
	, .aclr1          (1'b0)
	, .addressstall_a (1'b0)
	, .addressstall_b (1'b0)
	, .clock1         (1'b1)
	, .clocken0       (1'b1)
	, .clocken1       (1'b1)
	, .clocken2       (1'b1)
	, .clocken3       (1'b1)
	, .eccstatus      ()
	, .rden_a         (1'b1)
	, .rden_b         (1'b1)
	);
defparam
	altsyncram_component.address_reg_b                      = "CLOCK0",
	altsyncram_component.byteena_reg_b                      = "CLOCK0",
	altsyncram_component.byte_size                          = BYTE_W,
	altsyncram_component.clock_enable_input_a               = "BYPASS",
	altsyncram_component.clock_enable_input_b               = "BYPASS",
	altsyncram_component.clock_enable_output_a              = "BYPASS",
	altsyncram_component.clock_enable_output_b              = "BYPASS",
	altsyncram_component.indata_reg_b                       = "CLOCK0",
	altsyncram_component.intended_device_family             = "MAX 10",
	altsyncram_component.lpm_type                           = "altsyncram",
	altsyncram_component.numwords_a                         = ADDR_WORD_L,
	altsyncram_component.numwords_b                         = ADDR_WORD_L,
	altsyncram_component.operation_mode                     = "BIDIR_DUAL_PORT",
	altsyncram_component.outdata_aclr_a                     = "NONE",
	altsyncram_component.outdata_aclr_b                     = "NONE",
	altsyncram_component.outdata_reg_a                      = "CLOCK0",
	altsyncram_component.outdata_reg_b                      = "CLOCK0",
	altsyncram_component.power_up_uninitialized             = "TRUE",
	altsyncram_component.read_during_write_mode_mixed_ports = "DONT_CARE",
	altsyncram_component.read_during_write_mode_port_a      = "NEW_DATA_WITH_NBE_READ",
	altsyncram_component.read_during_write_mode_port_b      = "NEW_DATA_WITH_NBE_READ",
	altsyncram_component.widthad_a                          = ADDR_WORD_W,
	altsyncram_component.widthad_b                          = ADDR_WORD_W,
	altsyncram_component.width_a                            = DATA_W,
	altsyncram_component.width_b                            = DATA_W,
	altsyncram_component.width_byteena_a                    = BYTE_L,
	altsyncram_component.width_byteena_b                    = BYTE_L,
	altsyncram_component.wrcontrol_wraddress_reg_b          = "CLOCK0";

endmodule

