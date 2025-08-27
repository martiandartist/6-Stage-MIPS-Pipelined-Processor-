`timescale 1ns / 1ps
module mul(
      //  input clk,
       // input reset,
        input [31:0]data_1_out_new,
        input [31:0] data_2_out_new,
        input bypass_mul_out, 
        output reg [31:0] mul_result
    );
    always@(*)begin
   // if(reset)begin
  //  mul_result<=0;
   // end
   if(bypass_mul_out)begin
    mul_result<=data_1_out_new;
    end
    else begin
    mul_result<=data_1_out_new*data_2_out_new;
    end
    end
endmodule
