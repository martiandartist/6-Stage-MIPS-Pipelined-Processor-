`timescale 1ns / 1ps
module add_mul(
    input [5:0]id_add_opcode,
    input[4:0] id_add_writereg,
    
    output reg [4:0] add_mul_writereg,
    input clk,
    input reset, 
    input [31:0] add_result,
    input [31:0] data_1_out,
    input [31:0] data_2_out,
    input regdst,
    input regwrite,
    input memtoreg,
    input alusrc,
    input memread,
    input memwrite,
    input branch,
    input bypass_mul,
    input [4:0] source_reg_out,
    input [4:0] destination_reg_out, // rd only for mul
    input [4:0] terminal_reg_out,    // rt
    output reg [31:0] add_result_out, 
    output reg [31:0] data_1_out_new,
    output reg [31:0] data_2_out_new,
    output reg regdst_out,
    output reg regwrite_out,
    output reg memtoreg_out,
    output reg alusrc_out,
    output reg memread_out,
    output reg memwrite_out,
    output reg branch_out,
    output reg bypass_mul_out,
    output reg [4:0] source_reg_out_new,
    output reg [4:0] destination_reg_out_new,
    output reg [4:0] terminal_reg_out_new,
    output reg [5:0] add_mul_opcode
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset all outputs to zero or appropriate default values
        source_reg_out_new <= 5'b0;
        destination_reg_out_new <= 5'b0;
        terminal_reg_out_new <= 5'b0;
        data_1_out_new <= 32'b0;
        data_2_out_new <= 32'b0;
        memtoreg_out <= 1'b0;
        memread_out <= 1'b0;
        bypass_mul_out <= 1'b0;
        branch_out <= 1'b0;
        memwrite_out <= 1'b0;
        alusrc_out <= 1'b0;
        regdst_out <= 1'b0;
        regwrite_out <= 1'b0;
        add_result_out <= 32'b0;
        add_mul_opcode<=0;
        add_mul_writereg<=0;
    end else begin
        source_reg_out_new <= source_reg_out;
        destination_reg_out_new <= destination_reg_out;
        terminal_reg_out_new <= terminal_reg_out;
        data_1_out_new <= data_1_out;
        data_2_out_new <= data_2_out;
        memtoreg_out <= memtoreg;
        memread_out <= memread;
        bypass_mul_out <= bypass_mul;
        branch_out <= branch;
        memwrite_out <= memwrite;
        alusrc_out <= alusrc;
        regdst_out <= regdst;
        regwrite_out <= regwrite;
        add_result_out <= add_result;
        add_mul_opcode<=id_add_opcode;
        add_mul_writereg<=id_add_writereg;
    end
end

endmodule
