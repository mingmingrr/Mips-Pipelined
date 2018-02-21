`ifndef DATA_MEMORY_ROM_I
`define DATA_MEMORY_ROM_I

`include "Altera/Mf.v"
`include "Util/Math.v"
`include "Data/Control/Control.v"

// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on

module Data_Memory_rom #
	( parameter FILE = "asm/test0.mif"
	, parameter ADDR_L = 64
	, parameter ADDR_W = Util_Math_log2(ADDR_L)
	, parameter DATA_W = 32
	)
	( input [ADDR_W-1:0]  addr
	, `Data_Control_Control_T(input) ctrl
	, output [DATA_W-1:0] out
	);

`Util_Math_log2_expr

`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
// tri1 `Util_Control_Control_Clock(ctrl);
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

wire [DATA_W-1:0] sub_wire0;
assign out = sub_wire0;
// wire [DATA_W-1:0] out = sub_wire0[DATA_W-1:0];

altsyncram altsyncram_component
	( .address_a      (addr)
	, .clock0         (`Data_Control_Control_Clock(ctrl))
	, .q_a            (sub_wire0)
	, .aclr0          (1'b0)
	, .aclr1          (1'b0)
	, .address_b      (1'b1)
	, .addressstall_a (1'b0)
	, .addressstall_b (1'b0)
	, .byteena_a      (1'b1)
	, .byteena_b      (1'b1)
	, .clock1         (1'b1)
	, .clocken0       (1'b1)
	, .clocken1       (1'b1)
	, .clocken2       (1'b1)
	, .clocken3       (1'b1)
	, .data_a         ({32{1'b1}})
	, .data_b         (1'b1)
	, .eccstatus      ()
	, .q_b            ()
	, .rden_a         (1'b1)
	, .rden_b         (1'b1)
	, .wren_a         (1'b0)
	, .wren_b         (1'b0)
	);
defparam
	altsyncram_component.address_aclr_a         = "NONE",
	altsyncram_component.clock_enable_input_a   = "BYPASS",
	altsyncram_component.clock_enable_output_a  = "BYPASS",
	altsyncram_component.init_file              = FILE,
	altsyncram_component.intended_device_family = "MAX 10",
	altsyncram_component.lpm_hint               = "ENABLE_RUNTIME_MOD = NO",
	altsyncram_component.lpm_type               = "altsyncram",
	altsyncram_component.numwords_a             = ADDR_L,
	altsyncram_component.operation_mode         = "ROM",
	altsyncram_component.outdata_aclr_a         = "NONE",
	altsyncram_component.outdata_reg_a          = "UNREGISTERED",
	altsyncram_component.ram_block_type         = "M9K",
	altsyncram_component.widthad_a              = ADDR_W,
	altsyncram_component.width_a                = DATA_W,
	altsyncram_component.width_byteena_a        = 1;

endmodule

`endif
