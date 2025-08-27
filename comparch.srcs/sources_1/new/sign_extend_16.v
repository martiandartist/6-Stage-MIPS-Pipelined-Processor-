`timescale 1ns / 1ps
module sign_extend_16(
    input [15:0] offset,
    output [31:0] offset_new
    );
    
    assign offset_new = {{16{offset[15]}}, offset[15:0]};
    
endmodule