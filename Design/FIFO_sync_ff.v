`timescale 1ns / 1ps

module FIFO_sync_ff #(parameter WIDTH = 5)(
    input                  clk,
    input                  rst_n,
    input      [WIDTH-1:0] async_in,
    output reg [WIDTH-1:0] sync_out
);
    reg [WIDTH-1:0] stage1;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            stage1   <= {WIDTH{1'b0}};
            sync_out <= {WIDTH{1'b0}};
        end else begin
            stage1   <= async_in;
            sync_out <= stage1;
        end
    end
endmodule