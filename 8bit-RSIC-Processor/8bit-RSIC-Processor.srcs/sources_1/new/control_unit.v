module control_unit (
    input [15:0] instruction,
    input zero_flag,                    // From ALU, for conditional jumps
    output reg [3:0] alu_op,
    output reg reg_we,
    output reg mem_we,
    output reg mem_re,
    output reg alu_src,
    output reg pc_load,
    output reg pc_sel,
    output reg writeback_sel
);

    wire [3:0] opcode;
    assign opcode = instruction[15:12];

    always @(*) begin
        // Default values
        alu_op = 4'b0000;
        reg_we = 0;
        mem_we = 0;
        mem_re = 0;
        alu_src = 0;
        pc_load = 0;
        pc_sel = 0;
        writeback_sel = 0;

        case (opcode)
            4'b0000: begin // ADD
                alu_op = 4'b0000;
                reg_we = 1;
                alu_src = 0; 
            end
            4'b0001: begin // SUB
                alu_op = 4'b0001;
                reg_we = 1;
                alu_src = 0;   // Select register Data
            end
            4'b0010: begin // AND
                alu_op = 4'b0010;
                reg_we = 1;
                alu_src = 0;
            end
            4'b0011: begin // OR
                alu_op = 4'b0011;
                reg_we = 1;
                alu_src = 0;
            end
            4'b0100: begin // MOVI
                alu_op = 4'b0000; 
                reg_we = 1;
                alu_src = 1;      // Select Immediate Data
            end
            4'b0101: begin // LD
                reg_we = 1;
                mem_re = 1;
                writeback_sel = 1; // Data from memory
            end
            4'b0110: begin // ST
                mem_we = 1;
            end
            4'b0111: begin // JMP
                pc_load = 1;
                pc_sel = 1;
            end
            4'b1000: begin // JZ
                if (zero_flag) begin
                    pc_load = 1;
                    pc_sel = 1;
                end
            end
            4'b1111: begin // NOP
                // Do nothing
            end
            default: begin
                // Invalid opcode: Do nothing
            end
        endcase
    end

endmodule
