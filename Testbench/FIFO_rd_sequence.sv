`include "uvm_macros.svh"
import uvm_pkg::*;

class FIFO_rd_seq extends uvm_sequence #(FIFO_rd_item #(16));

    `uvm_object_utils(FIFO_rd_seq)

    function new(string name = "FIFO_rd_seq");
 
        super.new(name);
 
    endfunction

    task body();

        FIFO_rd_item #(16) rd_itm;

        repeat(1000) begin

            rd_itm = FIFO_rd_item #(16) :: type_id :: create("rd_itm");

            start_item(rd_itm);

            assert(rd_itm.randomize());

            finish_item(rd_itm);

            `uvm_info(get_type_name(),$sformatf("rd_en = %0d",rd_itm.rd_en),UVM_HIGH)

        end
      
    endtask
  
endclass