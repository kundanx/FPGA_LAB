`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.08.2025 10:27:09
// Design Name: 
// Module Name: register_file
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module register_file (
    input clk,
    input we,                          // Write enable
    input [3:0] wr_addr,               // Write register address (4 bits = 16 regs)
    input [7:0] wr_data,               // Data to write

    input [3:0] rd_addr1,              // Read port 1 address
    output [7:0] rd_data1,             // Read port 1 data

    input [3:0] rd_addr2,              // Read port 2 address
    output [7:0] rd_data2              // Read port 2 data
);

    // 16 registers, each 8 bits wide
    reg [7:0] registers [0:15];

     // Initialize all registers to zero
    integer i;
    initial begin
        for (i = 0; i < 16; i = i + 1) begin
            registers[i] = 8'b00000000;
        end
    end

    // Synchronous write
    always @(posedge clk) begin
        if (we) begin
            registers[wr_addr] <= wr_data;
        end
    end

    // Asynchronous read
    assign rd_data1 = registers[rd_addr1];
    assign rd_data2 = registers[rd_addr2];

endmodule

