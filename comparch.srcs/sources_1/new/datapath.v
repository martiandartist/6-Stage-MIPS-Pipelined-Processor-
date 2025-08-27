`timescale 1ns / 1ps
module datapath(
        input clk,
        input reset
    );
    wire [4:0] id_add_writereg,add_mul_writereg,mul_mem_writereg,mem_wb_writereg;
    wire [31:0] addi_sw_forward_out,lw_addi_forward;
    wire[25:0] address_jump;
    wire flush;
    wire [5:0]id_add_opcode;
    wire stall;
    wire [31:0]pc,pc_if_id;
    wire [31:0] pc_mux;
    wire [31:0] pc_4;
    wire [31:0] instruction_code;
    wire [4:0] source_reg;
    wire [4:0] destination_reg;//rd only for mul
    wire[4:0] terminal_reg;//rt
    wire [4:0]shamt;// only for mul
    wire[25:0] address;//jump
    wire[15:0]offset;
    wire [5:0] opcode;
    wire [5:0] funct;//only for mul
    wire  [9:0] imm_value;
    wire [31:0]offset_new;
    wire [31:0]imm_value_new;
    wire regdst_in, regwrite_in,memtoreg_in,memread_in,memwrite_in,alusrc_in, branch_in;
    wire [1:0] aluop_in,aluop;
    wire bypass_mul_in,flush_in, bypass_add_in;
    wire [4:0] read_reg_1, read_reg_2, writereg;
    wire [31:0] writedata, data_1, data_2,data_2_mux,add_result;
    wire [31:0] pc_out, imm_value_new_out, address_new_out, offset_new_out;
    wire [31:0] data_1_out, data_2_out,address_shift_2,pc_2,in_1;
    wire [4:0] source_reg_out, destination_reg_out, terminal_reg_out; 
    wire regdst, regwrite, memtoreg, alusrc, memread, memwrite, branch, bypass_mul, bypass_add;
    wire [31:0] add_result_out, pc_x, data_1_out_new, data_2_out_new,mul_result;
    wire [4:0] source_reg_out_new, destination_reg_out_new, terminal_reg_out_new;
    wire regdst_out, regwrite_out, memtoreg_out, alusrc_out, memread_out, memwrite_out, branch_out, bypass_mul_out;
    wire [31:0] add_result_out_new, pc_2_out_new, mul_result_out;
    wire memread_out_new, memwrite_out_new, memtoreg_out_new, regwrite_out_new,regwrite_out_new_new;
    wire [31:0] read_data,data_2_out_new_new,address_new;
    wire [31:0] add_result_out_new_new, mul_result_out_new, read_data_out;
    wire memtoreg_out_new_new,bypass_mul_out_new,bypass_mul_out_new_new;
   wire [2:0]forward_rs;
   wire [1:0]forward_rt;
   wire [4:0]mem_wb_rs,mem_wb_rt,mem_wb_rd;
   wire [4:0] mul_mem_rs,mul_mem_rt,mul_mem_rd;
   wire mem_wb_memread;
   wire [31:0] addi_forward;
   wire[5:0]add_mul_opcode,mul_mem_opcode,mem_wb_opcode;
    wire [31:0]data_1_out_new_forward,data_2_out_new_forward,data_1_out_forward;
    
    pc_mux u_pc_mux(.in_1(pc_4),.in_2(pc_x),.sel(flush),.out(pc_mux));
    //flush_in
    instruction_fetch pc_block(.stall(stall),.reset(reset),.clk(clk),.pc_mux(pc_mux),.pc(pc));
    
    adder_1 adder_block(.pc_in(pc),.pc(pc_4));
    
    instruction_memory im(.reset(reset),.pc(pc),.instruction_code(instruction_code));
    //flush_in
    
    flush u_flush(.flush(flush),.instruction_code(instruction_code));
    
    address_jump uut(.flush(flush),.instruction_code(instruction_code),.address_jump(address_jump));
    
    if_id if_id_block(.flush_in(flush_in),.stall(stall),.clk(clk),.pc_4(pc_4),.pc_if_id(pc_if_id), .reset(reset), .instruction_code(instruction_code), .source_reg(source_reg),.destination_reg(destination_reg),.terminal_reg(terminal_reg), .shamt(shamt),.address(address),.offset(offset),.opcode(opcode), .funct(funct),.imm_value(imm_value));
    
    stalling_unit su(.stall(stall),.id_add_opcode(id_add_opcode),
    .if_id_opcode(opcode),
    .if_id_rs(source_reg),
    .if_id_rt(terminal_reg),
    .id_add_rs( source_reg_out),
    .id_add_rt(terminal_reg_out),
    .id_add_rd(destination_reg_out),
    .add_mul_opcode(add_mul_opcode),
    .add_mul_rt(terminal_reg_out_new));
    
    forwarding_unit fu(.id_add_rs(source_reg_out),
    .add_mul_rs(source_reg_out_new),
    .mem_wb_rd(mem_wb_rd),
    .id_add_rt(terminal_reg_out),
    .add_mul_rt(terminal_reg_out_new),
    .mul_mem_rd(mul_mem_rd),
    .mul_mem_rt(mul_mem_rt),
    .mul_mem_rs(mul_mem_rs),
    .add_mul_rd(destination_reg_out_new),
    .id_add_opcode(id_add_opcode),
    .add_mul_opcode(add_mul_opcode),
    .mul_mem_opcode(mul_mem_opcode),
    .mem_wb_opcode(mem_wb_opcode),
    .mem_wb_rt(mem_wb_rt),
    .mem_wb_rs(mem_wb_rs),
    .if_id_opcode(opcode),
    .forward_rs(forward_rs),
    .forward_rt(forward_rt)
   
);
    
    shift_left_2 u_shift_left(.address_new_out(address_new),.address_shift_2(address_shift_2));
    
    adder_2 u_adder_2(.address_shift_2(address_shift_2), .pc_out(pc), .pc_2(pc_x));
     //if_id
    sign_extend_16 se_16(.offset(offset),.offset_new(offset_new));
    
    sign_extend_26 se_26(.address(address_jump),.address_new(address_new));
    //address
    zero_extend ze(.imm_value(imm_value),.imm_value_new(imm_value_new));
    
    control_unit u_control_unit (.stall(stall), .opcode(opcode),.regdst_in(regdst_in),.regwrite_in(regwrite_in),.memtoreg_in(memtoreg_in),.aluop_in(aluop_in),.alusrc_in(alusrc_in),.memread_in(memread_in), .memwrite_in(memwrite_in),.branch_in(branch_in),.bypass_mul_in(bypass_mul_in),.bypass_add_in(bypass_add_in),.flush_in(flush_in));
    
    mux_regdst u_regdst(.in_1(terminal_reg),.in_2(destination_reg),.sel(regdst_in),.out(writereg));
    
    instruction_decode u_instruction_decode (.read_reg_1(source_reg),.read_reg_2(terminal_reg), .regwrite_in(regwrite_out_new_new),.writedata(writedata), .writereg(mem_wb_writereg),.reset(reset),.data_1(data_1), .data_2(data_2));
    
    id_add u_id_add(.writereg(writereg),.id_add_writereg(id_add_writereg),.stall(stall),.reset(reset), .if_id_opcode(opcode),.id_add_opcode(id_add_opcode),.clk(clk),.source_reg(source_reg),.destination_reg(destination_reg),.terminal_reg(terminal_reg),.pc_2(pc_2),.offset_new(offset_new),.imm_value_new(imm_value_new),.data_1(data_1),.data_2(data_2),.regdst_in(regdst_in),.regwrite_in(regwrite_in),.memtoreg_in(memtoreg_in),.aluop_in(aluop_in),.alusrc_in(alusrc_in),.memread_in(memread_in),.memwrite_in(memwrite_in),.branch_in(branch_in),.bypass_mul_in(bypass_mul_in),.bypass_add_in(bypass_add_in),.pc_if_id(pc_if_id),.source_reg_out(source_reg_out),.destination_reg_out(destination_reg_out),.terminal_reg_out(terminal_reg_out),.imm_value_new_out(imm_value_new_out),.offset_new_out(offset_new_out),.data_1_out(data_1_out),.data_2_out(data_2_out),.regdst(regdst),.regwrite(regwrite),.memtoreg(memtoreg),.aluop(aluop),.alusrc(alusrc),.memread(memread),.memwrite(memwrite),.branch(branch),.bypass_mul(bypass_mul),.bypass_add(bypass_add));
      
    mux_addi_lw_sw u_mux_addi_lw_sw(.in_1(imm_value_new_out),.in_2(offset_new_out),.sel(alusrc),.out(data_2_mux));
   
   add_mul_mux u_add_mul_mux (
    .mul_mem_result(mul_result_out),         // from MEM stage of MUL
    .add_mul_result(add_result_out),         // from ADD or ADDI stage
    .mem_wb_result(read_data),           // from WB stage
    .data_1_out(data_1_out),                 // register file output
    .forward_rs(forward_rs),                 // forwarding control signal
    .data_1_out_forward(data_1_out_forward)  // output after forwarding
);
    
     addi_forward add_mux(
     .read_data(read_data),
     .forward_rs(forward_rs),
    .data_1_out(data_1_out),
    .add_result_out(add_result_out),
    .addi_forward(addi_forward),
     .mul_result(mul_result_out)
    );
    
//    lw_addi_mux u_lw_addi_mux (
//    .forward_rs(forward_rs),
//    .data_1_out(data_1_out),
//    .read_data(read_data),
//    .lw_addi_forward(lw_addi_forward)
//);
    
    add u_add(.data_1_out(addi_forward),.data_2_mux(data_2_mux),.bypass_add(bypass_add),.add_result(add_result));
    
    add_mul u_add_mul(.add_mul_writereg(add_mul_writereg),.id_add_writereg(id_add_writereg),.id_add_opcode(id_add_opcode),.add_mul_opcode(add_mul_opcode),.clk(clk),.reset(reset),.add_result(add_result),.data_1_out(data_1_out),.data_2_out(data_2_out),.regdst(regdst),.regwrite(regwrite),.memtoreg(memtoreg),.alusrc(alusrc),.memread(memread),.memwrite(memwrite), .branch(branch),.bypass_mul(bypass_mul),.source_reg_out(source_reg_out),.destination_reg_out(destination_reg_out),.terminal_reg_out(terminal_reg_out),.add_result_out(add_result_out),.data_1_out_new(data_1_out_new),.data_2_out_new(data_2_out_new),.regdst_out(regdst_out),.regwrite_out(regwrite_out),.memtoreg_out(memtoreg_out),.alusrc_out(alusrc_out),.memread_out(memread_out),.memwrite_out(memwrite_out),.branch_out(branch_out),.bypass_mul_out(bypass_mul_out),.source_reg_out_new(source_reg_out_new),.destination_reg_out_new(destination_reg_out_new),.terminal_reg_out_new(terminal_reg_out_new));
   
      mul_mem_mux U_MUL_MEM_MUX (
      .mul_result_out(mul_result_out),
    .data_1_out_new(data_1_out_new),
    .data_2_out_new(data_2_out_new),
    .add_result(add_result_out),
    .read_data(read_data),
    .forward_rs(forward_rs),
    .forward_rt(forward_rt),
    .data_1_out_new_forward(data_1_out_new_forward),
    .data_2_out_new_forward(data_2_out_new_forward)
);
    
    mul u_mul(.data_1_out_new(data_1_out_new_forward),.data_2_out_new(data_2_out_new_forward),.bypass_mul_out(bypass_mul_out),.mul_result(mul_result));
    
    mul_mem u_mul_mem(.add_mul_writereg(add_mul_writereg),.mul_mem_writereg(mul_mem_writereg),.add_mul_opcode(add_mul_opcode),.mul_mem_opcode(mul_mem_opcode),.mul_mem_rs(mul_mem_rs),.mul_mem_rt(mul_mem_rt),.mul_mem_rd(mul_mem_rd),.source_reg_out_new(source_reg_out_new),.destination_reg_out_new(destination_reg_out_new), .terminal_reg_out_new(terminal_reg_out_new),.data_2_out_new(data_2_out_new),.data_2_out_new_new(data_2_out_new_new),.bypass_mul_out(bypass_mul_out),.bypass_mul_out_new(bypass_mul_out_new),.clk(clk),.reset(reset),  .add_result_out(add_result_out),.mul_result(mul_result),.memread_out(memread_out),.memwrite_out(memwrite_out),.memtoreg_out(memtoreg_out),.regwrite_out(regwrite_out),.add_result_out_new(add_result_out_new),.memread_out_new(memread_out_new),.memwrite_out_new(memwrite_out_new),.mul_result_out(mul_result_out),.memtoreg_out_new(memtoreg_out_new),.regwrite_out_new(regwrite_out_new));
    
    mem u_mem(.add_result_out_new(add_result_out_new),.reset(reset),.write_data(addi_sw_forward_out),.memwrite_out_new(memwrite_out_new),.memread_out_new(memread_out_new),.read_data(read_data));
    
    addi_sw_forward u_addi_sw_forward(.forward_rt(forward_rt),           
.data_2_out(data_2_out_new),       
.add_result_out(add_result_out_new_new),   
.addi_sw_forward_out(addi_sw_forward_out) ) ;
    
    mem_wb u_mem_wb(.mem_wb_writereg(mem_wb_writereg),.mul_mem_writereg(mul_mem_writereg),.mem_wb_opcode(mem_wb_opcode),.mul_mem_opcode(mul_mem_opcode),.mul_mem_memread(memread_out_new),.mem_wb_memread(mem_wb_memread),.mul_mem_rs(mul_mem_rs),.mul_mem_rt(mul_mem_rt),.mul_mem_rd(mul_mem_rd),.mem_wb_rs(mem_wb_rs),.mem_wb_rt(mem_wb_rt),.mem_wb_rd(mem_wb_rd),.regwrite_out_new(regwrite_out_new),.regwrite_out_new_new(regwrite_out_new_new),.bypass_mul_out_new(bypass_mul_out_new),.bypass_mul_out_new_new(bypass_mul_out_new_new),.clk(clk),.reset(reset),.add_result_out_new(add_result_out_new),.mul_result_out(mul_result_out),.memtoreg_out_new(memtoreg_out_new),.read_data(read_data),.add_result_out_new_new(add_result_out_new_new),.mul_result_out_new(mul_result_out_new),.memtoreg_out_new_new(memtoreg_out_new_new),.read_data_out(read_data_out));
    
   mux_add_mul_write add_mul_write(.in_1(mul_result_out_new),.in_2(add_result_out_new_new),.sel(bypass_mul_out_new_new),.out(in_1));
    
     wb u_wb(.in_1(in_1),.in_2(read_data_out),.sel(memtoreg_out_new_new),.out(writedata));
endmodule
