`timescale 1ns / 1ps
module sign_extend_26(
    input [25:0] address,
    output [31:0] address_new
    );

    assign address_new = {{6{address[25]}}, address[25:0]};

endmodule
