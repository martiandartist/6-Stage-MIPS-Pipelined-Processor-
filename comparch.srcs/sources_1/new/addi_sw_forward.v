`timescale 1ns / 1ps

module addi_sw_forward(
        input [1:0]         forward_rt,
        input [31:0]        data_2_out,
        input [31:0]        add_result_out,
        output reg [31:0]   addi_sw_forward_out
    );
    always@(*)begin
    if(forward_rt==2'b11)begin
    addi_sw_forward_out=add_result_out;
    end
    else begin
     addi_sw_forward_out=data_2_out;
     end
     end
endmodule
