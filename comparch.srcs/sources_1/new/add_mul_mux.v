`timescale 1ns / 1ps
module add_mul_mux(
    input [31:0] mul_mem_result,add_mul_result,mem_wb_result,//2nd for addi then addi
    input [31:0] data_1_out,
    input [2:0] forward_rs,
    output reg [31:0]data_1_out_forward
    );
    always@(*)begin
    if(forward_rs==3'b000)begin
    data_1_out_forward=data_1_out;
    end
    else if(forward_rs==3'b001)begin//lw stall addi
    data_1_out_forward=mem_wb_result;
    end
    else if(forward_rs==3'b100)begin//mul then addi
    data_1_out_forward=mul_mem_result;
    end
    else if(forward_rs==3'b101)begin//addi then addi
    data_1_out_forward=add_mul_result;
    end
    else begin
   data_1_out_forward=data_1_out;
    end
    end
endmodule
