`include "uvm_macros.svh"
import uvm_pkg::*;

class FIFO_wr_driver extends uvm_driver #(FIFO_wr_item);

    virtual FIFO_inf.DRIVER_WR inf;

    `uvm_component_utils(FIFO_wr_driver)

    function new(string name = "FIFO_wr_driver", uvm_component parent);
 
        super.new(name, parent);
 
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        if(!uvm_config_db#(virtual FIFO_inf.DRIVER_WR) :: get(this,"*","inf",inf))

            `uvm_fatal("NOINF","Interface not found")

    endfunction

    task reset();

        inf.drv_cb_wr.wr_rst_n <= 1'b0;
        repeat(3) @(inf.drv_cb_wr);
        inf.drv_cb_wr.wr_rst_n <= 1'b1;
      
    endtask

    task run_phase(uvm_phase phase);

        FIFO_wr_item wr_itm;

        @(inf.drv_cb_wr);
        reset();

        forever begin

            seq_item_port.get_next_item(wr_itm);

            @(inf.drv_cb_wr);
            inf.drv_cb_wr.data_in <= wr_itm.data_in;
            inf.drv_cb_wr.wr_en <= wr_itm.wr_en;

            seq_item_port.item_done();

            `uvm_info(get_type_name(),$sformatf("wr_en = %0d | data_in = %0d",inf.drv_cb_wr.wr_en,inf.drv_cb_wr.data_in),UVM_HIGH)

            end
      
    endtask
  
endclass