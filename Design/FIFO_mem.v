`timescale 1ns / 1ps

module FIFO_mem #(parameter DATA_WIDTH = 16, parameter ADDR_WIDTH = 4)(
    input                          wr_clk,
    input                          wr_en_gated,
    input      [ADDR_WIDTH-1:0]    wr_addr,
    input      [DATA_WIDTH-1:0]    data_in,

    input                          rd_clk,
    input      [ADDR_WIDTH-1:0]    rd_addr,
    output reg [DATA_WIDTH-1:0]    data_out
);
    reg [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

    always @(posedge wr_clk) begin
        if (wr_en_gated)
            mem[wr_addr] <= data_in;
    end

    always @(posedge rd_clk) begin
        data_out <= mem[rd_addr];
    end
endmodule