// vim: set ft=verilog:

`ifndef UTIL_MATH_M
`define UTIL_MATH_M

module Util_Math;

function integer log2;
	input x; integer x;
	begin
		log2 = 0;
		x = x - 1;
		while (x > 0) begin
			log2 = log2 + 1;
			x = x >> 1;
		end
	end
endfunction
`define Util_Math_log2_expr \
	function integer Util_Math_log2; \
		input x; integer x; \
		begin \
			Util_Math_log2 = 0; \
			x = x - 1; \
			while (x > 0) begin \
				Util_Math_log2 = Util_Math_log2 + 1; \
				x = x >> 1; \
			end \
		end \
	endfunction

endmodule

`endif
