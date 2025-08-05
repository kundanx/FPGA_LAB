module instruction_rom (
    input [7:0] addr,
    output reg [15:0] data
);

    always @(*) begin
        case (addr)
            8'd0: data = 16'b0100_0001_00000101; // MOVI R1, 5
            8'd1: data = 16'b0100_0010_00000011; // MOVI R2, 3
            8'd2: data = 16'b0000_0011_00000010; // ADD R3, R2
            8'd3: data = 16'b0110_0011_00010100; // ST R3, 20
            8'd4: data = 16'b0101_0100_00010100; // LD R4, 20
            8'd5: data = 16'b0001_0100_00000010; // SUB R4, R2
            8'd6: data = 16'b1000_0000_00001000; // JZ 8
            8'd7: data = 16'b0111_0000_00001001; // JMP 9
            8'd8: data = 16'b0100_0000_00000001; // MOVI R0, 1
            8'd9: data = 16'b0100_0000_00000010; // MOVI R0, 2
            8'd10: data = 16'b1111_0000_00000000; //  NOP

            default: data = 16'b1111_0000_00000000; // NOP for safety
        endcase
    end

endmodule
