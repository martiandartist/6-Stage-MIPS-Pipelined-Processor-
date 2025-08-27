`timescale 1ns / 1ps
module instruction_decode(
                input [4:0]read_reg_1,
                input [4:0]read_reg_2,
                input regwrite_in,
                input reset,
                //input clk,
                input [31:0]writedata,
                input [4:0]writereg,
                output[31:0]data_1,
                output[31:0]data_2
    );
    reg [31:0] reg_mem [31:0];
    integer k;
    assign data_1=reg_mem[read_reg_1];
    assign data_2=reg_mem[read_reg_2];
      always @(*) begin
        if (reset) begin
            for (k = 0; k < 31; k = k + 1) begin
                reg_mem[k] = k;
            end
            
        end
         else begin
             if (regwrite_in && writereg != 5'b0) begin // Prevent writing to r0
                reg_mem[writereg] <= writedata;
            end
            reg_mem[0] <= 32'b0;
        end
    end
endmodule
