// vim: set ft=verilog:

`ifndef SEVENSEG_SEVENSEG_M
`define SEVENSEG_SEVENSEG_M

module SevenSeg_SevenSeg;

function [6:0] decodeHighTrue([3:0] in);
	case(in)
		4'h0    : decodeHighTrue = 7'h7E;
		4'h1    : decodeHighTrue = 7'h30;
		4'h2    : decodeHighTrue = 7'h6D;
		4'h3    : decodeHighTrue = 7'h79;
		4'h4    : decodeHighTrue = 7'h33;
		4'h5    : decodeHighTrue = 7'h5B;
		4'h6    : decodeHighTrue = 7'h5F;
		4'h7    : decodeHighTrue = 7'h70;
		4'h8    : decodeHighTrue = 7'h7F;
		4'h9    : decodeHighTrue = 7'h7B;
		4'hA    : decodeHighTrue = 7'h77;
		4'hB    : decodeHighTrue = 7'h1F;
		4'hC    : decodeHighTrue = 7'h4E;
		4'hD    : decodeHighTrue = 7'h3D;
		4'hE    : decodeHighTrue = 7'h4F;
		4'hF    : decodeHighTrue = 7'h47;
		default : decodeHighTrue = 7'h00;
	endcase
endfunction

function [6:0] decodeLowTrue([3:0] in);
	decodeLowTrue = ~decodeHighTrue(in);
endfunction

endmodule

`endif
