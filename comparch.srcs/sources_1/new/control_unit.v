`timescale 1ns / 1ps
module control_unit(
    input [5:0] opcode,
    input stall, // New input
    output reg regdst_in,
    output reg regwrite_in,
    output reg memtoreg_in,
    output reg [1:0] aluop_in,
    output reg alusrc_in,
    output reg memread_in,
    output reg memwrite_in,
    output reg branch_in,
    output reg bypass_mul_in,
    output reg bypass_add_in,
    output reg flush_in
);

always @(*) begin
    if (!stall) begin
        case (opcode)
            6'b100011: begin // lw
                regdst_in     = 0;
                regwrite_in   = 1;
                memtoreg_in   = 1;
                aluop_in      = 2'b00;
                alusrc_in     = 1;
                memread_in    = 1;
                memwrite_in   = 0;
                branch_in     = 0;
                bypass_mul_in = 1;
                bypass_add_in = 0;
                flush_in      = 0;
            end

            6'b101011: begin // sw
                regdst_in     = 0;
                regwrite_in   = 0;
                memtoreg_in   = 0;
                aluop_in      = 2'b00;
                alusrc_in     = 1;
                memread_in    = 0;
                memwrite_in   = 1;
                branch_in     = 0;
                bypass_mul_in = 1;
                bypass_add_in = 0;
                flush_in      = 0;
            end

            6'b000010: begin // jump
                regdst_in     = 0;
                regwrite_in   = 0;
                memtoreg_in   = 0;
                aluop_in      = 2'b00;
                alusrc_in     = 0;
                memread_in    = 0;
                memwrite_in   = 0;
                branch_in     = 1;
                bypass_mul_in = 0;
                bypass_add_in = 0;
                flush_in      = 1;
            end

            6'b000000: begin // mul
                regdst_in     = 1;
                regwrite_in   = 1;
                memtoreg_in   = 0;
                aluop_in      = 2'b10;
                alusrc_in     = 0;
                memread_in    = 0;
                memwrite_in   = 0;
                branch_in     = 0;
                bypass_mul_in = 0;
                bypass_add_in = 1;
                flush_in      = 0;
            end

            6'b000001: begin // addi
                regdst_in     = 0;
                regwrite_in   = 1;
                memtoreg_in   = 0;
                aluop_in      = 2'b10;
                alusrc_in     = 0;  // Per your previous request
                memread_in    = 0;
                memwrite_in   = 0;
                branch_in     = 0;
                bypass_mul_in = 1;
                bypass_add_in = 0;
                flush_in      = 0;
            end

            default: begin // NOP or unsupported opcode
                regdst_in     = 0;
                regwrite_in   = 0;
                memtoreg_in   = 0;
                aluop_in      = 2'b00;
                alusrc_in     = 0;
                memread_in    = 0;
                memwrite_in   = 0;
                branch_in     = 0;
                bypass_mul_in = 0;
                bypass_add_in = 0;
                flush_in      = 0;
            end
        endcase
    end else begin
        // Stall case: insert NOP
        regdst_in     = 0;
        regwrite_in   = 0;
        memtoreg_in   = 0;
        aluop_in      = 2'b00;
        alusrc_in     = 0;
        memread_in    = 0;
        memwrite_in   = 0;
        branch_in     = 0;
        bypass_mul_in = 0;
        bypass_add_in = 0;
        flush_in      = 0;
    end
end

endmodule
