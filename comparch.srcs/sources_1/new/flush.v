`timescale 1ns / 1ps


module flush(input [31:0] instruction_code,
output reg flush

    );
    always@(*)begin
    if(instruction_code[31:26]==6'b000010)begin
    flush=1;
    end
    else begin 
    flush=0;
    end
    end
endmodule
