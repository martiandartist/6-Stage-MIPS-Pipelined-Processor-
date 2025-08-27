`timescale 1ns / 1ps

module tb_datapath;

    // Inputs
    reg clk;
    reg reset;

    datapath uut (
        .clk(clk), 
        .reset(reset)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    initial begin
  
   

        // Example: Reset and reinitialize
        reset = 1;
        #5;
        reset = 0;
        #150;
        $finish;
    end
endmodule
