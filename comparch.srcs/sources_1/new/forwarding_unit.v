`timescale 1ns / 1ps
module forwarding_unit(
    input[4:0] id_add_rs,add_mul_rs,mem_wb_rd,
    input[4:0] id_add_rt,add_mul_rt,//for ml as rt is source
    input[4:0] mul_mem_rd,mul_mem_rt,mul_mem_rs,//rt is destination for rest except mul
    input [4:0] add_mul_rd,//mul rd as destination
    input [5:0] id_add_opcode,add_mul_opcode,mul_mem_opcode,mem_wb_opcode,if_id_opcode,
    input [4:0]mem_wb_rt,mem_wb_rs,
    
    output reg [2:0] forward_rs,
    output reg [1:0] forward_rt
    ); 
    //00-no forward, 01-mem/wb, 10- mul/mem, 11- add/mul
    always@(*)begin
    forward_rs=3'b000;
    forward_rt=2'b00;
    
    //only for given instruction we need 3 forwarding
    //first lw then mul for both rt and rs
    //then for addi and sw
    //lw then mul(rt)
    if(mem_wb_opcode==6'b100011 && add_mul_opcode==6'b000000 && mem_wb_rt==add_mul_rt)begin
    forward_rt=2'b01;
    end
    //lw then mul(rs)
    else if(mem_wb_opcode==6'b100011 && add_mul_opcode==6'b000000 && mem_wb_rt==add_mul_rs)begin
    forward_rs=3'b001;
    end
    //addi then sw 
    else if(mem_wb_opcode==6'b000001 && mul_mem_opcode==6'b101011 && mul_mem_rt==mem_wb_rt)begin
    forward_rt=2'b11;
    end
    //addi then addi
    else if(add_mul_opcode==6'b000001 && id_add_opcode==6'b000001 && add_mul_rt==id_add_rs)begin
    forward_rs=3'b111;
    end
    //lw then addi
    else if(mem_wb_opcode==6'b100011 && id_add_opcode==6'b000001 && mem_wb_rt==id_add_rs)begin
    forward_rs=3'b011;
    end
    //mul then addi
    else if(mul_mem_opcode==6'b000000 && id_add_opcode==6'b000001 && mul_mem_rd==id_add_rs)begin
    forward_rs=3'b101;
    end
    //mul then mul rs
//    else if(mul_mem_opcode==6'b000000 && add_mul_opcode==6'b000000 && mul_mem_rd==add_mul_rs)begin
//    forward_rs=3'b100;
//    end
    // mul then mul rt
//    else if(mul_mem_opcode==6'b000000 && add_mul_opcode==6'b000000 && mul_mem_rd==add_mul_rt)begin
//    forward_rt=2'b11;
//    end
//    else if(mem_wb_opcode==6'b000010 && mul_mem_opcode==6'b101011 && mem_wb_rt==mul_mem_rt)begin
//    forward_rt=2'b11;
//    end
    //first check add/lw hazard
     //for add then mul(rs)
//   if (add_mul_regwrite && add_mul_bypass_mul && id_add_bypass_add &&
//            (add_mul_rt != 0) && 
//            (add_mul_rt == id_add_rs)) begin
//            forward_rs = 3'b011;
//        end
//        // for add then mul(rt)
//       else if (add_mul_regwrite && add_mul_bypass_mul && id_add_bypass_add &&
//            (add_mul_rt != 0) && 
//            (add_mul_rt == id_add_rt)) begin
//            forward_rt = 2'b11;
//        end
//        // mul followed by addi/lw
//       else if (add_mul_regwrite && add_mul_bypass_add && id_add_bypass_mul &&
//            (add_mul_rd != 0) && 
//            (add_mul_rd == id_add_rs)) begin
//            forward_rs = 3'b100;//check for value
//        end
//        // lw followed by mul(rt)
//      else if (mem_wb_regwrite && mul_mem_bypass_add && mem_wb_memread &&
//            (mem_wb_rt != 0) && 
//            (mul_mem_rt == mem_wb_rs)) begin
//            forward_rt = 2'b10;
//        end
//        //lw followed by mul(rs)
//         else if (mem_wb_regwrite && mul_mem_bypass_add && mem_wb_memread &&
//            (mem_wb_rt != 0) && 
//            (mul_mem_rs == mem_wb_rs)) begin
//            forward_rs = 3'b010;
//        end
//        //lw then some instruction then add
//        else if (mem_wb_regwrite && mem_wb_memread && id_add_bypass_mul &&
//                (mem_wb_rt != 0) && 
//                (mem_wb_rt == id_add_rs)) begin
//            forward_rs = 3'b001;
//        end  
    //addi then sw
    
        end
endmodule
