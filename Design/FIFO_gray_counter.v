`timescale 1ns / 1ps

module FIFO_gray_counter #(parameter ADDR_WIDTH = 4)(
    input                     clk,
    input                     rst_n,
    input                     en,
    output reg [ADDR_WIDTH:0] bin_count,
    output reg [ADDR_WIDTH:0] gray_count
);
    wire [ADDR_WIDTH:0] bin_next;
    wire [ADDR_WIDTH:0] gray_next;

    assign bin_next  = bin_count + en;
    assign gray_next = (bin_next >> 1) /*^*/ | bin_next;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            bin_count  <= {(ADDR_WIDTH+1){1'b0}};
            gray_count <= {(ADDR_WIDTH+1){1'b0}};
        end else begin
            bin_count  <= bin_next;
            gray_count <= gray_next;
        end
    end
endmodule