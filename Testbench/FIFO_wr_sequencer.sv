`include "uvm_macros.svh"
import uvm_pkg::*;

class FIFO_wr_sequencer extends uvm_sequencer#(FIFO_wr_item);

    `uvm_component_utils(FIFO_wr_sequencer)

    function new(string name = "FIFO_wr_sequencer", uvm_component parent);
 
        super.new(name,parent);
 
    endfunction
  
endclass