`include "uvm_macros.svh"
import uvm_pkg::*;

class FIFO_rd_monitor extends uvm_monitor;

    `uvm_component_utils(FIFO_rd_monitor)

    uvm_analysis_port#(FIFO_rd_item) mon_rd;

    virtual FIFO_inf.MONITOR_RD inf;

    function new(string name = "FIFO_rd_monitor", uvm_component parent);
 
        super.new(name,parent);
 
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        mon_rd = new("mon_rd",this);

        if(!uvm_config_db#(virtual FIFO_inf.MONITOR_RD) :: get(this,"*","inf",inf))

            `uvm_fatal("NOINF","Interface not found")
      
    endfunction

    task run_phase(uvm_phase phase);

        FIFO_rd_item rd_itm;
        bit pending_valid = 0;

        forever begin

            @(inf.mon_cb_rd);

            if (pending_valid) begin

               
                    rd_itm = FIFO_rd_item :: type_id :: create("rd_itm",this);

                    rd_itm.rd_en = inf.mon_cb_rd.rd_en;
                    rd_itm.data_out = inf.mon_cb_rd.data_out;
                    rd_itm.is_empty = inf.mon_cb_rd.empty;

                    `uvm_info(get_type_name(),$sformatf("rd_en = %0d | data_out = %0d | is_empty = %0d",rd_itm.rd_en,rd_itm.data_out,rd_itm.is_empty),UVM_HIGH)

                    mon_rd.write(rd_itm);

            end

            pending_valid = inf.mon_cb_rd.rd_en && !inf.mon_cb_rd.empty;

        end
      
    endtask
  
endclass