`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.08.2025 03:40:07
// Design Name: 
// Module Name: tb_topmodule
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


`timescale 1ns / 1ps

module tb_topmodule;

    reg clk;
    reg reset;

    // Instantiate the processor
    topmodule uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation: 10ns period (100 MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;

        // Hold reset for some time
        #20;
        reset = 0;

        // Run simulation for a while
        #500;

        $finish;
    end

endmodule
