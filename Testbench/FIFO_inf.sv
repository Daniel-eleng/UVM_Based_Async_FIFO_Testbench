interface FIFO_inf #(parameter DATA_WIDTH = 16, parameter DEPTH = 16) 
                    (input logic wr_clk, input logic rd_clk);

    logic [DATA_WIDTH-1:0] data_in = '0;
    logic wr_rst_n = 1'b0;
    logic rd_rst_n = 1'b0;
    logic wr_en = 1'b0;
    logic rd_en = 1'b0;
    logic full;
    logic empty;
    logic [DATA_WIDTH-1:0] data_out;

    clocking drv_cb_wr @(posedge wr_clk);
        default input #1step output #1;
        output data_in, wr_en, wr_rst_n;
        input full;
    endclocking

    clocking drv_cb_rd @(posedge rd_clk);
        default input #1step output #1;
        output rd_en, rd_rst_n;
        input data_out, empty;
    endclocking

    clocking mon_cb_wr @(posedge wr_clk);
        default input #1step output #1;
        input data_in, full, wr_rst_n, wr_en;
    endclocking

    clocking mon_cb_rd @(posedge rd_clk);
        default input #1step output #1;
        input data_out, empty, rd_rst_n, rd_en;
    endclocking

    modport DRIVER_WR  (clocking drv_cb_wr);
    modport DRIVER_RD  (clocking drv_cb_rd);
    modport MONITOR_WR (clocking mon_cb_wr);
    modport MONITOR_RD (clocking mon_cb_rd);

endinterface