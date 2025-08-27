`timescale 1ns / 1ps
module mux_regdst(
    input [4:0] in_1,
    input [4:0]in_2,
    input sel,
    output[4:0] out
    );
     assign out=sel?in_2:in_1;
endmodule
