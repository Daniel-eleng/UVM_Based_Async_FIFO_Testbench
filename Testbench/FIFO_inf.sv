interface FIFO_inf #(parameter DATA_WIDTH = 16, parameter DEPTH = 16) 
                    (input logic w_clk, input logic rd_clk);

    logic [DATA_WIDTH-1:0] data_in;
    logic w_rst_n;
    logic rd_rst_n;
    logic wr_en;
    logic rd_en;
    logic full;
    logic empty;
    logic [DATA_WIDTH-1:0] data_out;
    
endinterface