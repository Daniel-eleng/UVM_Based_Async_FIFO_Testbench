`include "uvm_macros.svh"
import uvm_pkg::*;

module FIFO_top;

    bit wr_clk;
    bit rd_clk;

    always #5 wr_clk = ~wr_clk;

    always #10 rd_clk = ~rd_clk;

    FIFO_inf inf(wr_clk,rd_clk);

    FIFO_Design DUT(.w_clk(inf.wr_clk),
                    .rd_clk(inf.rd_clk),
                    .data_in(inf.data_in),
                    .w_rst_n(inf.wr_rst_n),
                    .rd_rst_n(inf.rd_rst_n),
                    .wr_en(inf.wr_en),
                    .rd_en(inf.rd_en),
                    .full(inf.full),
                    .empty(inf.empty),
                    .data_out(inf.data_out));

    initial begin

        uvm_config_db#(virtual FIFO_inf.DRIVER_WR)::set(null,"*","inf",inf);
        uvm_config_db#(virtual FIFO_inf.DRIVER_RD)::set(null,"*","inf",inf);
        uvm_config_db#(virtual FIFO_inf.MONITOR_WR)::set(null,"*","inf",inf);
        uvm_config_db#(virtual FIFO_inf.MONITOR_RD)::set(null,"*","inf",inf);
        run_test("FIFO_test");
    
    end

endmodule