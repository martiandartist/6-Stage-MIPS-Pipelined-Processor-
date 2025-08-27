`timescale 1ns / 1ps
module mem(
    input [31:0] add_result_out_new,
    input reset,
    input [31:0] write_data,
    input memwrite_out_new,
    input memread_out_new,
    output reg [31:0] read_data
);
    // Memory array - byte addressable (8-bit)
    reg [7:0] data_mem [0:1023]; // 1024 bytes of memory
    
    // Word-aligned address calculation
    wire [31:0] word_addr;
    assign word_addr = {add_result_out_new[31:2], 2'b00};
    
    // Extract byte offset within the word
    wire [1:0] byte_offset;
    assign byte_offset = add_result_out_new[1:0];
    
    // Extract base memory address (remove bottom 2 bits for byte addressing)
    wire [9:0] mem_base;
    assign mem_base = add_result_out_new[11:2];
    
    always @(*) begin
        if (reset) begin
            // Initialize memory in big-endian format
            // For value 9 (0x00000009)
            data_mem[0] <= 8'h00; // MSB
            data_mem[1] <= 8'h00;
            data_mem[2] <= 8'h00;
            data_mem[3] <= 8'h09; // LSB
            
            // For value 1 (0x00000001)
            data_mem[4] <= 8'h00; // MSB
            data_mem[5] <= 8'h00;
            data_mem[6] <= 8'h00;
            data_mem[7] <= 8'h01; // LSB
            
            // Initialize other memory locations if needed
        end else begin
            if (memread_out_new) begin // lw or lb
                // For word access in big-endian
                // In big-endian: MSB at lowest address
                read_data[31:24] <= data_mem[mem_base*4 + 0]; // MSB
                read_data[23:16] <= data_mem[mem_base*4 + 1];
                read_data[15:8]  <= data_mem[mem_base*4 + 2];
                read_data[7:0]   <= data_mem[mem_base*4 + 3]; // LSB
            end
            
            if (memwrite_out_new) begin // sw or sb
                // For word access in big-endian
                data_mem[word_addr*4 + 0] <= write_data[31:24]; // MSB
                data_mem[word_addr*4 + 1] <= write_data[23:16];
                data_mem[word_addr*4 + 2] <= write_data[15:8];
                data_mem[word_addr*4 + 3] <= write_data[7:0];   // LSB
            end
        end
    end
    
    // For byte-specific operations, add the following logic:
    /*
    // Additional inputs to specify whether it's a byte operation
    input is_byte_op, 
    
    // Byte operation handling
    if (is_byte_op && memread_out_new) begin // lb
        case(byte_offset)
            2'b00: read_data <= {24'b0, data_mem[mem_base*4 + 0]}; // MSB (big-endian)
            2'b01: read_data <= {24'b0, data_mem[mem_base*4 + 1]};
            2'b10: read_data <= {24'b0, data_mem[mem_base*4 + 2]};
            2'b11: read_data <= {24'b0, data_mem[mem_base*4 + 3]}; // LSB
        endcase
    end
    
    if (is_byte_op && memwrite_out_new) begin // sb
        case(byte_offset)
            2'b00: data_mem[mem_base*4 + 0] <= write_data[7:0]; // Store to MSB (big-endian)
            2'b01: data_mem[mem_base*4 + 1] <= write_data[7:0];
            2'b10: data_mem[mem_base*4 + 2] <= write_data[7:0];
            2'b11: data_mem[mem_base*4 + 3] <= write_data[7:0]; // Store to LSB
        endcase
    end
    */
endmodule