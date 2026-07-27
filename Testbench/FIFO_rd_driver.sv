`include "uvm_macros.svh"
import uvm_pkg::*;

class FIFO_rd_driver extends uvm_driver #(FIFO_rd_item);

    virtual FIFO_inf.DRIVER_RD inf;

    `uvm_component_utils(FIFO_rd_driver)

    function new(string name = "FIFO_rd_driver", uvm_component parent);
 
        super.new(name, parent);
 
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        if(!uvm_config_db#(virtual FIFO_inf.DRIVER_RD) :: get(this,"*","inf",inf))

            `uvm_fatal("NOINF","Interface not found")

    endfunction

    task reset();

        inf.drv_cb_rd.rd_rst_n <= 1'b0;
        repeat(3) @(inf.drv_cb_rd);
        inf.drv_cb_rd.rd_rst_n <= 1'b1;
      
    endtask

    task run_phase(uvm_phase phase);

        FIFO_rd_item rd_itm;
 
        reset();

        forever begin

            seq_item_port.get_next_item(rd_itm);

            @(inf.drv_cb_rd);

            inf.drv_cb_rd.rd_en <= rd_itm.rd_en;

            seq_item_port.item_done();

            `uvm_info(get_type_name(),$sformatf("rd_en = %0d",inf.drv_cb_rd.rd_en),UVM_HIGH)

            end
      
    endtask
  
endclass