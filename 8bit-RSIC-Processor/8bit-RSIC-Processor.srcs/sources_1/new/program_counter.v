module pc (
    input clk,
    input reset,
    input [7:0] pc_in,
    input pc_load,
    output reg [7:0] pc_out
);

always @(posedge clk or posedge reset) begin
    if (reset)
        pc_out <= 8'd0;
     else if (pc_load)
        pc_out <= pc_in;
     else
        pc_out <= pc_out + 1;
end
endmodule