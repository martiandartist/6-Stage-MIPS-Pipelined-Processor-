`timescale 1ns / 1ps
module instruction_fetch(input reset,
                        input clk,stall,flush,
                         input [31:0] pc_mux,
                        output reg [31:0] pc
    );
    always@(posedge clk or posedge reset)begin
    if(reset)begin
    pc<=0;
    end
    else if(stall);
    else begin
     pc<=pc_mux;
    end
    end
endmodule
