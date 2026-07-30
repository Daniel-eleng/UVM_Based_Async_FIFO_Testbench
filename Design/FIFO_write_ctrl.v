`timescale 1ns / 1ps

module FIFO_write_ctrl #(parameter ADDR_WIDTH = 4)(
    input                       wr_clk,
    input                       wr_rst_n,
    input                       wr_en,
    input      [ADDR_WIDTH:0]   rd_gray_sync,

    output reg                  full,
    output     [ADDR_WIDTH-1:0] wr_addr,
    output     [ADDR_WIDTH:0]   wr_gray,
    output                      wr_en_gated
);
    wire [ADDR_WIDTH:0] wr_bin, wr_bin_next, wr_gray_next;
    wire full_next;

    assign wr_en_gated  = wr_en & ~full;

    FIFO_gray_counter #(.ADDR_WIDTH(ADDR_WIDTH)) u_wr_gray_cnt (
        .clk        (wr_clk),
        .rst_n      (wr_rst_n),
        .en         (wr_en_gated),
        .bin_count  (wr_bin),
        .gray_count (wr_gray)
    );

    assign wr_addr      = wr_bin[ADDR_WIDTH-1:0];
    assign wr_bin_next  = wr_bin + wr_en_gated;
    assign wr_gray_next = (wr_bin_next >> 1) ^ wr_bin_next;

    assign full_next = (wr_gray == {~rd_gray_sync[ADDR_WIDTH:ADDR_WIDTH-1],
                                           rd_gray_sync[ADDR_WIDTH-2:0]});

    always @(posedge wr_clk or negedge wr_rst_n) begin
        if (!wr_rst_n)
            full <= 1'b0;
        else
            full <= full_next;
    end
endmodule