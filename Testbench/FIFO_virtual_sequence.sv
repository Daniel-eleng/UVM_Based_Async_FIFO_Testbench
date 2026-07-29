`include "uvm_macros.svh"
import uvm_pkg::*;

class FIFO_virtual_sequence extends uvm_sequence;

    `uvm_object_utils(FIFO_virtual_sequence)
    `uvm_declare_p_sequencer(FIFO_virtual_sequencer)

    FIFO_wr_sequence wr_seq;

    FIFO_rd_sequence rd_seq;

    function new(string name = "FIFO_virtual_sequence");
 
        super.new(name);
 
    endfunction
    
    task pre_body();

        wr_seq = FIFO_wr_sequence :: type_id :: create("wr_seq");

        rd_seq = FIFO_rd_sequence :: type_id :: create("rd_seq");
      
    endtask

    task body();

        fork

            wr_seq.start(p_sequencer.wr_seqr);

            rd_seq.start(p_sequencer.rd_seqr);

        join
      
    endtask
  
endclass