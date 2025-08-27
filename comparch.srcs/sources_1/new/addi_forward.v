`timescale 1ns / 1ps
module addi_forward(
    input [2:0]forward_rs,
    input [31:0]data_1_out,
    input [31:0]add_result_out,read_data,mul_result,
    output reg [31:0] addi_forward
    );
    always@(*)begin
    if(forward_rs==3'b111)begin
    addi_forward<=add_result_out;
    end
    else if(forward_rs==3'b101)begin
    addi_forward<=mul_result;
    end
    else if(forward_rs==3'b011)begin
    addi_forward<=read_data;
    end
    else begin
    addi_forward<=data_1_out;
    end
    end
endmodule
