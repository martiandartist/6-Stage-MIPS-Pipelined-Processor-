`timescale 1ns / 1ps
module lw_addi_mux(
    input [2:0]forward_rs,
    input [31:0]data_1_out,
    input [31:0]read_data,
    output reg [31:0] lw_addi_forward
    );
    always@(*)begin
    if(forward_rs==3'b011)begin
    lw_addi_forward<=read_data;
    end
    else begin
    lw_addi_forward<=data_1_out;
    end
    end
endmodule

