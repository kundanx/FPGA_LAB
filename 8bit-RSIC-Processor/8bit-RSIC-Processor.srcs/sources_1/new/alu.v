module alu (
    input [7:0] a,
    input [7:0] b,
    input [3:0] alu_op,
    output reg [7:0] result,
    output zero_flag
);

    always @(*) begin
        case (alu_op)
            4'b0000: result = a + b;
            4'b0001: result = a - b;
            4'b0010: result = a & b;
            4'b0011: result = a | b;
            4'b0100: result = b;        // For MOVI
            default: result = 8'd0;
        endcase
    end

    assign zero_flag = (result == 8'd0);

endmodule
