`timescale 1ns / 1ps
//mem then mem left
module mul_mem_mux(
    input [31:0]data_1_out_new,data_2_out_new,
    input[31:0]add_result,read_data,mul_result_out,// 2nd one from mem lw
    input[2:0]forward_rs,
    input [1:0]forward_rt,
    output reg [31:0] data_1_out_new_forward,data_2_out_new_forward
    );
    always@(*)begin
    // add then mul rs
    //if(forward_rs==3'b011)begin
    //data_1_out_new_forward=add_result;
   // data_2_out_new_forward=data_2_out_new;
    //end
    //lw then mul rs
     if(forward_rs==3'b001)begin
    data_1_out_new_forward=read_data;
    data_2_out_new_forward=data_2_out_new;
    end
    // add then mul rt
 //   else if(forward_rt==2'b11)begin
  //  data_1_out_new_forward=data_1_out_new;
  //  data_2_out_new_forward=add_result;
  //  end
    //lw then mul rt
     else if(forward_rt==2'b01)begin
    data_1_out_new_forward=data_1_out_new;
    data_2_out_new_forward=read_data;
    end
    //mul the mul rt
     else if(forward_rt==2'b11)begin
    data_1_out_new_forward=data_1_out_new;
    data_2_out_new_forward=mul_result_out;
    end
    // mul then mul rs
     else if(forward_rs==3'b100)begin
    data_1_out_new_forward=mul_result_out;
    data_2_out_new_forward=data_2_out_new;
    end
    else begin 
    data_1_out_new_forward=data_1_out_new;
    data_2_out_new_forward=data_2_out_new;
    end
    end
endmodule
