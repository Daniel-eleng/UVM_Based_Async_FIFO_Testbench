`timescale 1ns / 1ps

module FIFO_read_ctrl #(parameter ADDR_WIDTH = 4)(
    input                       rd_clk,
    input                       rd_rst_n,
    input                       rd_en,
    input      [ADDR_WIDTH:0]   wr_gray_sync,

    output reg                  empty,
    output     [ADDR_WIDTH-1:0] rd_addr,
    output     [ADDR_WIDTH:0]   rd_gray
);
    wire [ADDR_WIDTH:0] rd_bin, rd_bin_next, rd_gray_next;
    wire empty_next;
    wire rd_en_gated;

    assign rd_en_gated = rd_en & ~empty;

    FIFO_gray_counter #(.ADDR_WIDTH(ADDR_WIDTH)) u_rd_gray_cnt (
        .clk        (rd_clk),
        .rst_n      (rd_rst_n),
        .en         (rd_en_gated),
        .bin_count  (rd_bin),
        .gray_count (rd_gray)
    );

    assign rd_addr      = rd_bin[ADDR_WIDTH-1:0];
    assign rd_bin_next  = rd_bin + rd_en_gated;
    assign rd_gray_next = (rd_bin_next >> 1) ^ rd_bin_next;

    assign empty_next = (rd_gray_next == wr_gray_sync);

    always @(posedge rd_clk or negedge rd_rst_n) begin
        if (!rd_rst_n)
            empty <= 1'b1;
        else
            empty <= empty_next;
    end
endmodule