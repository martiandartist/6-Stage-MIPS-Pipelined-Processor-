`timescale 1ns / 1ps
module mem_wb(
        input [5:0]mul_mem_opcode,
        input [4:0] mul_mem_writereg,
        output reg [4:0] mem_wb_writereg,
        input clk,
        input reset,
        input regwrite_out_new,
        input [31:0]add_result_out_new,
        input [31:0]mul_result_out,
        input [4:0] mul_mem_rs,mul_mem_rt,mul_mem_rd,
        input mul_mem_memread,
        input memtoreg_out_new,
        input [31:0] read_data,
        input bypass_mul_out_new,
        output reg bypass_mul_out_new_new,
        output reg [31:0] add_result_out_new_new,
        output reg [31:0] mul_result_out_new,
        output reg memtoreg_out_new_new,
        output reg regwrite_out_new_new,
        output reg [31:0]read_data_out,
        output reg [4:0] mem_wb_rs,mem_wb_rt,mem_wb_rd,
        output reg mem_wb_memread,
        output reg [5:0] mem_wb_opcode
    );
    always@(posedge clk)begin
    if(reset)begin
    add_result_out_new_new<=0;
    mul_result_out_new<=0;
    read_data_out<=0;
    memtoreg_out_new_new<=0;
    bypass_mul_out_new_new<=0;
    regwrite_out_new_new<=0;
    mem_wb_rs<=0;
    mem_wb_rt<=0;
    mem_wb_rd<=0;
    mem_wb_memread<=0;
    mem_wb_opcode<=0;
    mem_wb_writereg<=0;
    end
    else begin
     mem_wb_rs<=mul_mem_rs;
 mem_wb_rt<=mul_mem_rt;
 mem_wb_rd<=mul_mem_rd;
 mem_wb_memread<=mul_mem_memread;
    add_result_out_new_new<=add_result_out_new;
    read_data_out<=read_data;
    memtoreg_out_new_new<=memtoreg_out_new;
    mul_result_out_new<=mul_result_out;
    bypass_mul_out_new_new<=bypass_mul_out_new;
    regwrite_out_new_new<=regwrite_out_new;
    mem_wb_opcode<=mul_mem_opcode;
    mem_wb_writereg<=mul_mem_writereg;
    end
    end
    
endmodule
