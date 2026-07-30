
module FIFO_assertions (
    input logic w_clk,
    input logic rd_clk,
    input logic w_rst_n,
    input logic rd_rst_n,
    input logic full,
    input logic empty
);

    property no_x_on_full;
        @(posedge w_clk) disable iff (!w_rst_n)
        !$isunknown(full);
    endproperty
 
    assert property (no_x_on_full)
        else $error("SVA_FULL_X: full became X/Z after reset release");

    
    property no_x_on_empty;
        @(posedge rd_clk) disable iff (!rd_rst_n)
        !$isunknown(empty);
    endproperty
 
    assert property (no_x_on_empty)
        else $error("SVA_EMPTY_X: empty became X/Z after reset release");

    
    property full_empty_not_both;
        @(posedge w_clk) disable iff (!w_rst_n)
        !(full && empty);
    endproperty
 
    assert property (full_empty_not_both)
        else $error("SVA_FULL_EMPTY: full and empty asserted simultaneously");

endmodule

bind FIFO_Design FIFO_assertions u_assertions (.*);