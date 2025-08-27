`timescale 1ns / 1ps
module zero_extend(
        input [9:0] imm_value,
        output [31:0] imm_value_new
    );
      assign imm_value_new={{22'b0},imm_value};
endmodule
