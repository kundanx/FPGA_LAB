module topmodule (
    input clk,
    input reset
);

// Program counter

wire [7:0] pc_out, pc_next;
wire pc_load, pc_sel;

pc pc_unit (
    .clk(clk),
    .reset(reset),
    .pc_in(pc_next),
    .pc_load(pc_load),
    .pc_out(pc_out)
);


// Instruction ROM

wire [15:0] instruction;

instruction_rom ir_rom_unit(
    .addr(pc_out),
    .data(instruction)
);


// control unit 

wire [3:0] alu_op;
wire reg_we, mem_we, mem_re;
wire alu_src, writeback_sel;
wire zero_flag;

control_unit cu_unit(
    .instruction(instruction),
    .zero_flag(zero_flag),
    .alu_op(alu_op),
    .reg_we(reg_we),
    .mem_we(mem_we),
    .mem_re(mem_re),
    .alu_src(alu_src),
    .pc_load(pc_load),
    .pc_sel(pc_sel),
    .writeback_sel(writeback_sel)
);

// Register File
wire [3:0] rd, rs;
wire [7:0] reg_data1, reg_data2;
wire [7:0] reg_write_data;

assign rd = instruction[11:8];
assign rs = instruction[3:0];
// assign reg_write_data = instruction[7:0];

register_file rf_unit (
    .clk(clk),
    .we(reg_we),
    .wr_addr(rd),
    .wr_data(reg_write_data),
    .rd_addr1(rd),
    .rd_data1(reg_data1),
    .rd_addr2(rs),
    .rd_data2(reg_data2)
);

// ALU
wire [7:0] alu_result;
wire [7:0] alu_in_b;

assign alu_in_b = (alu_src) ? instruction[7:0] : reg_data2;

alu alu_unit(
    .a(reg_data1),
    .b(alu_in_b),
    .alu_op(alu_op),
    .result(alu_result),
    .zero_flag(zero_flag)
);


// Data Memory (RAM)

wire [7:0] mem_data_out;

data_mem data_ram (
    .clk(clk),
    .addr(instruction[7:0]),
    .we(mem_we),
    .re(mem_re),
    .write_data(reg_data1),
    .read_data(mem_data_out)
);

// === Writeback MUX ===
    assign reg_write_data = (writeback_sel) ? mem_data_out : alu_result;

    // === PC Update Logic ===
    assign pc_next = (pc_sel) ? instruction[7:0] : pc_out + 1;

endmodule
