`include "uvm_macros.svh"
import uvm_pkg::*;

class FIFO_rd_item #(parameter DATA_WIDTH = 16) extends uvm_sequence_item;

    rand logic rd_en;
    logic [DATA_WIDTH-1:0] data_out;
    logic empty;

    typedef FIFO_rd_item #(DATA_WIDTH) this_itm;
    `uvm_object_param_utils(this_itm)

    function new(string name = "FIFO_rd_item");
        super.new(name);
    endfunction

endclass