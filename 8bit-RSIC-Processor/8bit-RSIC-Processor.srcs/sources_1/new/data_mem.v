`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.08.2025 03:28:43
// Design Name: 
// Module Name: data_mem
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


module data_mem (
    input clk,
    input [7:0] addr,             // 8-bit address = 256 words
    input we,                     // Write enable
    input re,                     // Read enable (optional, could be tied to 1)
    input [7:0] write_data,       // Data to write
    output reg [7:0] read_data    // Data to read
);

    // 256 x 8-bit memory
    reg [7:0] mem [0:255];

    // Synchronous write
    always @(posedge clk) begin
        if (we) begin
            mem[addr] <= write_data;
        end
    end

    // Asynchronous read
    always @(*) begin
        if (re)
            read_data = mem[addr];
        else
            read_data = 8'd0;
    end

endmodule

