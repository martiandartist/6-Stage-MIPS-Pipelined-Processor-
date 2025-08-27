`timescale 1ns / 1ps
module mul_mem(
    input [5:0] add_mul_opcode,
    input[4:0] add_mul_writereg,
    output reg [4:0] mul_mem_writereg,
    input clk,
    input reset,
    input [31:0] add_result_out,data_2_out_new,
    input [31:0] mul_result,
   input[4:0] source_reg_out_new,      
  input [4:0] destination_reg_out_new, 
  input [4:0] terminal_reg_out_new   ,  
    input bypass_mul_out,
    input memread_out,
    input memwrite_out,
    input memtoreg_out,
    input regwrite_out,
    output reg bypass_mul_out_new,
    output reg [31:0] add_result_out_new,data_2_out_new_new,
    output reg [5:0] mul_mem_opcode,
    output reg memread_out_new,
    output reg memwrite_out_new,
    output reg [31:0] mul_result_out,
    output reg memtoreg_out_new,
    output reg regwrite_out_new,
    output reg [4:0] mul_mem_rs,mul_mem_rt,mul_mem_rd
    
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset all outputs to zero or appropriate default values
        add_result_out_new <= 32'b0;
       mul_mem_rs<=1'b0;    
       mul_mem_rt<=1'b0;
       mul_mem_rd <=1'b0;   
        memread_out_new <= 1'b0;
        memwrite_out_new <= 1'b0;
        mul_result_out <= 32'b0;
        memtoreg_out_new <= 1'b0;
        regwrite_out_new <= 1'b0;
        bypass_mul_out_new<=1'b0;
        data_2_out_new_new<=0;
        mul_mem_opcode<=0;
        mul_mem_writereg<=0;
    end else begin
        add_result_out_new <= add_result_out;
        mul_mem_rs<= source_reg_out_new;      
        mul_mem_rt<=terminal_reg_out_new; 
        mul_mem_rd <=destination_reg_out_new  ;  
       memread_out_new <= memread_out;
        memwrite_out_new <= memwrite_out;
        mul_result_out <= mul_result;
        memtoreg_out_new <= memtoreg_out;
        regwrite_out_new <= regwrite_out;
        bypass_mul_out_new<=bypass_mul_out;
        data_2_out_new_new<=data_2_out_new;
        mul_mem_opcode<=add_mul_opcode;
        mul_mem_writereg<=add_mul_writereg;
    end
end

endmodule
