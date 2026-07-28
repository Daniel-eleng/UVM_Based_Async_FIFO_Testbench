`include "uvm_macros.svh"
import uvm_pkg::*;

class FIFO_rd_agent extends uvm_agent;

    FIFO_rd_driver rd_drv;
    FIFO_rd_monitor rd_mon;
    FIFO_rd_sequencer rd_seqr;

    `uvm_component_utils(FIFO_rd_agent)

    function new(string name = "FIFO_rd_agent", uvm_component parent);
 
        super.new(name,parent);
 
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        rd_drv = FIFO_rd_driver :: type_id :: create("rd_drv",this);
        rd_mon = FIFO_rd_monitor :: type_id :: create("rd_mon",this);
        rd_seqr = FIFO_rd_sequencer :: type_id :: create("rd_seqr",this);
      
    endfunction

    function void connect_phase(uvm_phase phase);

        super.connect_phase(phase);

        rd_drv.seq_item_port.connect(rd_seqr.seq_item_export);
      
    endfunction
  
endclass