`timescale 1ns / 1ps
module if_id(
    input clk,
    input reset,
    input stall,
    input flush_in,
    input [31:0] instruction_code,
    input [31:0] pc_4,
    output reg [4:0] source_reg,
    output reg [4:0] destination_reg, // rd (only for mul)
    output reg [4:0] terminal_reg,    // rt
    output reg [4:0] shamt,           // only for mul
    output reg [25:0] address,        // jump
    output reg [15:0] offset,
    output reg [5:0] opcode,
    output reg [5:0] funct,           // only for mul
    output reg [9:0] imm_value,
    output reg [31:0] pc_if_id
);



always @(posedge clk or posedge reset) begin
    if (reset) begin
        opcode          <= 6'b0;
        source_reg      <= 5'b00;
        terminal_reg    <= 5'b00000;
        destination_reg <= 5'b00000;
        offset          <= 16'b0;
        address         <= 26'b0;
        shamt           <= 5'b00000;
        funct           <= 6'b000000;
        imm_value       <= 10'b0;
        pc_if_id        <= 32'b0;
//    end else if (flush_in) begin
//        opcode          <= 6'b000000;
//        source_reg      <= 5'b00000;
//        terminal_reg    <= 5'b00000;
//        destination_reg <= 5'b00000;
//        offset          <= 16'b0;
//        address         <= 26'b0;
//        shamt           <= 5'b00000;
//        funct           <= 6'b000000;
//        imm_value       <= 10'b0;
//        pc_if_id        <= pc_4;
    end 
    else if (!stall) begin
        opcode          <= instruction_code[31:26];
        source_reg      <= instruction_code[25:21];
        terminal_reg    <= instruction_code[20:16];
        destination_reg <= instruction_code[15:11];
        offset          <= instruction_code[15:0];
        address         <= instruction_code[25:0];
        shamt           <= instruction_code[10:6];
        funct           <= instruction_code[5:0];
        imm_value       <= instruction_code[15:6];
        pc_if_id        <= pc_4;
    end
end

endmodule
