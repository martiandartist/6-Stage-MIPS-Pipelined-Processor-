`timescale 1ns / 1ps


module address_jump(
    input flush,
    input [31:0] instruction_code,
    output reg[25:0]address_jump
    );
    always@(*)begin
    if(flush)begin
    address_jump=instruction_code[25:0];
    end
    end
endmodule
