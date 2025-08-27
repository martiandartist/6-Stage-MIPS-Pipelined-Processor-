`timescale 1ns / 1ps
module adder_2(
    input [31:0] address_shift_2,
    input [31:0] pc_out,
    output [31:0] pc_2
    );
    assign pc_2={pc_out[31:28],address_shift_2};
endmodule
