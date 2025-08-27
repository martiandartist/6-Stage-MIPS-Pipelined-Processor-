`timescale 1ns / 1ps
module add(
       // input clk,
       // input reset,
        input [31:0] data_1_out,
        input [31:0] data_2_mux,
        input bypass_add,
        output reg [31:0] add_result
    );
    always@(*)begin
   // if(reset)begin
   // add_result<=0;
   // end
   // else begin
    if(bypass_add)begin
    add_result<=data_1_out;
    end
    else begin 
    add_result<=data_1_out+data_2_mux;
    end
    end
   // end
endmodule
