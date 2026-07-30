`timescale 1ns / 1ps

module FIFO_Design #(parameter DATA_WIDTH = 16, parameter DEPTH = 16)(
    input                       w_clk,
    input                       rd_clk,
    input      [DATA_WIDTH-1:0] data_in,
    input                       w_rst_n,
    input                       rd_rst_n,
    input                       wr_en,
    input                       rd_en,
    output                      full,
    output                      empty,
    output     [DATA_WIDTH-1:0] data_out
);
    localparam ADDR_WIDTH = $clog2(DEPTH);

    wire [ADDR_WIDTH:0]   wr_gray, rd_gray;
    wire [ADDR_WIDTH:0]   wr_gray_sync_to_rd, rd_gray_sync_to_wr;
    wire [ADDR_WIDTH-1:0] wr_addr, rd_addr;
    wire                  wr_en_gated;

    FIFO_write_ctrl #(.ADDR_WIDTH(ADDR_WIDTH)) u_wr_ctrl (
        .wr_clk       (w_clk),
        .wr_rst_n     (w_rst_n),
        .wr_en        (wr_en),
        .rd_gray_sync (rd_gray_sync_to_wr),
        .full         (full),
        .wr_addr      (wr_addr),
        .wr_gray      (wr_gray),
        .wr_en_gated  (wr_en_gated)
    );

    FIFO_read_ctrl #(.ADDR_WIDTH(ADDR_WIDTH)) u_rd_ctrl (
        .rd_clk       (rd_clk),
        .rd_rst_n     (rd_rst_n),
        .rd_en        (rd_en),
        .wr_gray_sync (wr_gray_sync_to_rd),
        .empty        (empty),
        .rd_addr      (rd_addr),
        .rd_gray      (rd_gray)
    );

    FIFO_sync_ff #(.WIDTH(ADDR_WIDTH+1)) u_sync_wr2rd (
        .clk      (rd_clk),
        .rst_n    (rd_rst_n),
        .async_in (wr_gray),
        .sync_out (wr_gray_sync_to_rd)
    );

    FIFO_sync_ff #(.WIDTH(ADDR_WIDTH+1)) u_sync_rd2wr (
        .clk      (w_clk),
        .rst_n    (w_rst_n),
        .async_in (rd_gray),
        .sync_out (rd_gray_sync_to_wr)
    );

    FIFO_mem #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) u_mem (
        .wr_clk      (w_clk),
        .wr_en_gated (wr_en_gated),
        .wr_addr     (/*wr_addr*/rd_addr),
        .data_in     (data_in),
        .rd_clk      (rd_clk),
        .rd_addr     (rd_addr),
        .data_out    (data_out)
    );

endmodule