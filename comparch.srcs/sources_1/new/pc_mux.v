`timescale 1ns / 1ps
module pc_mux(
        input [31:0]in_1,
        input [31:0]in_2,
        input sel,
        output [31:0]out
    );
   assign out=sel?in_2:in_1;
endmodule
