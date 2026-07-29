`include "uvm_macros.svh"
import uvm_pkg::*;

class FIFO_wr_seq extends uvm_sequence #(FIFO_wr_item #(16));

    `uvm_object_utils(FIFO_wr_seq)

    function new(string name = "FIFO_wr_seq");
 
        super.new(name);
 
    endfunction

    task body();

        FIFO_wr_item #(16) wr_itm;

        repeat(1000) begin

            wr_itm = FIFO_wr_item #(16) :: type_id :: create("wr_itm");

            start_item(wr_itm);

            assert(wr_itm.randomize() with {wr_en == 1;});

            finish_item(wr_itm);

            `uvm_info(get_type_name(),$sformatf("Check: correctness of the randomization | data_in = %0d | wr_en = %0d",wr_itm.data_in,wr_itm.wr_en),UVM_HIGH)

        end
      
    endtask
  
endclass