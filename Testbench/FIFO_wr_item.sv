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

    constraint data_in_dist {
    data_in dist {
        0                        := 20,
        (1<<DATA_WIDTH)-1        := 20,
        [1 : (1<<DATA_WIDTH)-2]  :/ 60
    };
}

endclass