`timescale 1ns / 1ps
module instruction_memory(
    input [31:0] pc,
    input reset,
    output reg [31:0] instruction_code
);
     reg [7:0] mem [40:0];
    always @(*) begin
   if (reset) begin
           mem[0] = 8'h00;  // opcode
    mem[1] = 8'h22;  // rs & rt
    mem[2] = 8'h18;  // rd & shamt
    mem[3] = 8'h18;  // funct
           mem[4] = 8'h00;
    mem[5] = 8'h64;
    mem[6] = 8'h20;
    mem[7] = 8'h18;
                end       
    end
     always @(*) begin
            instruction_code = {mem[pc], mem[pc+1], mem[pc+2], mem[pc+3]};          
    end
endmodule
