`include "uvm_macros.svh"
import uvm_pkg::*;

class FIFO_wr_agent extends uvm_agent;

    FIFO_wr_driver wr_drv;
    FIFO_wr_monitor wr_mon;
    FIFO_wr_sequencer wr_seqr;

    `uvm_component_utils(FIFO_wr_agent)

    function new(string name = "FIFO_wr_agent", uvm_component parent);
 
        super.new(name,parent);
 
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        wr_drv = FIFO_wr_driver :: type_id :: create("wr_drv",this);
        wr_mon = FIFO_wr_monitor :: type_id :: create("wr_mon",this);
        wr_seqr = FIFO_wr_sequencer :: type_id :: create("wr_seqr",this);
      
    endfunction

    function void connect_phase(uvm_phase phase);

        super.connect_phase(phase);

        wr_drv.seq_item_port.connect(wr_seqr.seq_item_export);
      
    endfunction
  
endclass