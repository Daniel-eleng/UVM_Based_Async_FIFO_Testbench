`include "uvm_macros.svh"
import uvm_pkg::*;

class FIFO_virtual_sequencer extends uvm_sequencer;

    `uvm_component_utils(FIFO_virtual_sequencer)

    FIFO_wr_sequencer wr_seqr;

    FIFO_rd_sequencer rd_seqr;

    function new(string name = "FIFO_virtual_sequencer", uvm_component parent);
 
        super.new(name,parent);
 
    endfunction
  
endclass