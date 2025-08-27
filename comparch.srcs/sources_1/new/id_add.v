`timescale 1ns / 1ps
module id_add(
    input clk,stall,
    input reset, // Active high reset
    input [4:0] source_reg,
    input [4:0] destination_reg, // rd only for mul
    input [4:0] terminal_reg, // rt
    input [31:0] pc_if_id,
    input [31:0] offset_new,
    input [4:0] writereg,
    output reg [4:0] id_add_writereg,
    input [31:0] imm_value_new,
    input [31:0] data_1,
    input [31:0] data_2,
    input regdst_in,
    input regwrite_in,
    input memtoreg_in,
    input [1:0] aluop_in,
    input alusrc_in,
    input memread_in,
    input memwrite_in,
    input branch_in,
    input bypass_mul_in,
    input bypass_add_in,
    input [5:0] if_id_opcode,
    output reg [31:0] pc_2,
    output reg [4:0] source_reg_out,
    output reg [4:0] destination_reg_out,
    output reg [4:0] terminal_reg_out,
    output reg [31:0] imm_value_new_out,
    output reg [5:0]id_add_opcode,
    output reg [31:0] offset_new_out,
    output reg [31:0] data_1_out,
    output reg [31:0] data_2_out,
    output reg regdst,
    output reg regwrite,
    output reg memtoreg,
    output reg [1:0] aluop,
    output reg alusrc,
    output reg memread,
    output reg memwrite,
    output reg branch,
    output reg bypass_mul,
    output reg bypass_add
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            source_reg_out <= 5'b0;
            destination_reg_out <= 5'b0;
            terminal_reg_out <= 5'b0;
            offset_new_out <= 32'b0;
            imm_value_new_out <= 32'b0;
            id_add_opcode<=6'b0;
            pc_2 <= 32'b0;
            data_1_out <= 32'b0;
            data_2_out <= 32'b0;
            aluop <= 2'b0;
            memtoreg <= 0;
            memread <= 0;
            bypass_mul <= 0;
            bypass_add <= 0;
            branch <= 0;
            memwrite <= 0;
            alusrc <= 0;
            regdst <= 0;
            regwrite <= 0;
            id_add_writereg<=0;
        end 
        else  begin
            source_reg_out <= source_reg;
            destination_reg_out <= destination_reg;
            terminal_reg_out <= terminal_reg;
            offset_new_out <= offset_new;
            imm_value_new_out <= imm_value_new;
            id_add_opcode<=if_id_opcode;
            pc_2 <= pc_if_id;
            data_1_out <= data_1;
            data_2_out <= data_2;
            aluop <= aluop_in;
            memtoreg <= memtoreg_in;
            memread <= memread_in;
            bypass_mul <= bypass_mul_in;
            bypass_add <= bypass_add_in;
            branch <= branch_in;
            memwrite <= memwrite_in;
            alusrc <= alusrc_in;
            regdst <= regdst_in;
            regwrite <= regwrite_in;
            id_add_writereg<=writereg;
        end
    end

endmodule
