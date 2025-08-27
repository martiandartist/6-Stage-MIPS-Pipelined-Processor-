`timescale 1ns / 1ps
module adder_1(
        input clk,
        input [31:0] pc_in,
        output reg [31:0] pc
    );
    always@(*)begin
     pc<=pc_in+4;
    end
endmodule
