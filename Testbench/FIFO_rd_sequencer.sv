`include "uvm_macros.svh"
import uvm_pkg::*;

class FIFO_rd_sequencer extends uvm_sequencer#(FIFO_rd_item);

    `uvm_component_utils(FIFO_rd_sequencer)

    function new(string name = "FIFO_rd_sequencer", uvm_component parent);
 
        super.new(name,parent);
 
    endfunction
  
endclass