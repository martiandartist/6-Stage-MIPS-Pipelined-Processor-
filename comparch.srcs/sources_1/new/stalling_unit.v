`timescale 1ns / 1ps
module stalling_unit(
    input [5:0] id_add_opcode, if_id_opcode,add_mul_opcode,
    input [4:0] if_id_rs, if_id_rt, id_add_rs, id_add_rt, id_add_rd,add_mul_rt,
    output reg stall
);

always @(*) begin
    stall = 0; // default no stall

    if ((if_id_opcode == 6'b000001 && id_add_opcode == 6'b000000) && (if_id_rs == id_add_rd)) begin
        // mul then addi
        stall = 1;
    end
    else if ((if_id_opcode == 6'b100011 && id_add_opcode == 6'b000000) && (if_id_rs == id_add_rd)) begin
       //  mul then lw
        stall = 1;
    end
    else if ((if_id_opcode == 6'b000000 && id_add_opcode == 6'b100011) && (if_id_rs == id_add_rt)) begin
        // lw then mul rs
        stall = 1;
    end
    else if ((if_id_opcode == 6'b000000 && id_add_opcode == 6'b100011) && (if_id_rt == id_add_rt)) begin
        // lw then mul rt
        stall = 1;
    end
    else if ((if_id_opcode == 6'b000001 && id_add_opcode == 6'b100011) && (if_id_rs == id_add_rt)) begin
        // lw then addi (2 stalls)
        stall = 1;
    end
  //  else if ((if_id_opcode == 6'b101011 && id_add_opcode == 6'b000001) && (if_id_rs == id_add_rt)) begin
//         lw then addi (2 stalls)first stall
    //    stall = 1;
    //end
    else if ((if_id_opcode == 6'b000001 && add_mul_opcode == 6'b100011) && (if_id_rs == add_mul_rt)) begin
//         lw then addi (2 stalls)first stall
        stall = 1;
    end
    //mul them mul rs
    else if ((if_id_opcode == 6'b000000 && id_add_opcode == 6'b000000) && (if_id_rs == id_add_rd)) begin
       //  mul then mul rs
        stall = 1;
    end
    else if ((if_id_opcode == 6'b000000 && id_add_opcode == 6'b000000) && (if_id_rt == id_add_rd)) begin
       //  mul then mul rt
        stall = 1;
    end
   // else if ((if_id_opcode == 6'b101011 && id_add_opcode == 6'b000001) && (if_id_rt == id_add_rt)) begin
        // addi then sw
     //   stall = 1;
    //end
    else begin
    stall=0;
    end
end

endmodule
