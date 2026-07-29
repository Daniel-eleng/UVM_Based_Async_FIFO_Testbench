`include "uvm_macros.svh"
import uvm_pkg::*;

class FIFO_test extends uvm_test;

    `uvm_component_utils(FIFO_test)

    FIFO_env env;

    FIFO_virtual_sequence virt_seq;

    function new(string name = "FIFO_test", uvm_component parent);
 
        super.new(name,parent);
 
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        env = FIFO_env :: type_id :: create("env",this);
      
    endfunction

    task run_phase(uvm_phase phase);

        phase.raise_objection(this);

        virt_seq = FIFO_virtual_sequence :: type_id :: create("virt_seq");

        virt_seq.start(env.virt_seqr);

        phase.drop_objection(this);
      
    endtask
  
endclass