`include "uvm_macros.svh"
import uvm_pkg::*;

class FIFO_wr_item #(parameter DATA_WIDTH = 16) extends uvm_sequence_item;

    rand logic [DATA_WIDTH-1:0] data_in;
    rand logic wr_en;
    logic full;

    typedef FIFO_wr_item #(DATA_WIDTH) this_itm;
    `uvm_object_param_utils(this_itm)

    function new(string name = "FIFO_wr_item");
        super.new(name);
    endfunction

endclass