`include "uvm_macros.svh"
import uvm_pkg::*;

class FIFO_driver extends uvm_driver#(FIFO_seq_item);

    `uvm_component_utils(FIFO_driver)

    virtual FIFO_inf inf;

    function new(string name = "FIFO_driver",uvm_component parent);
 
        super.new(name,parent);
 
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        if(!uvm_config_db#(virtual FIFO_inf) :: get(this,"*","inf",inf))

            `uvm_fatal("NOINF","Interface not found")
      
    endfunction

    task run_phase(uvm_phase phase);

        FIFO_seq_item sq_itm;

        forever begin
            
            seq_item_port.get_next_item(sq_itm);

            inf.data_in <= sq_itm.data_in;
            inf.wr_en <= sq_itm.wr_en;
            inf.rd_en <= sq_itm.rd_en;

            #1;

            seq_item_port.item_done();

            `uvm_info(get_type_name(),$sformatf("data_in = %0d | wr_en = %0d | rd_en = %0d",inf.data_int,inf.wr_en,inf.rd_en),UVM_HIGH)
        end
      
    endtask
  
endclass