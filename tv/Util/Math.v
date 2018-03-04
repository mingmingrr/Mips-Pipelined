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

