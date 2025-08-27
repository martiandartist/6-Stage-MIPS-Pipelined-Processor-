`timescale 1ns / 1ps
module shift_left_2(
        input [31:0] address_new_out,
        output [31:0] address_shift_2
    );
    assign address_shift_2=address_new_out<<2;
endmodule
