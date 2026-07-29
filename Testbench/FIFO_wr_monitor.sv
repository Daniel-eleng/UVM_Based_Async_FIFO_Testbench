`include "uvm_macros.svh"
import uvm_pkg::*;

class FIFO_wr_monitor extends uvm_monitor;

    `uvm_component_utils(FIFO_wr_monitor)

    uvm_analysis_port#(FIFO_wr_item) mon_wr;

    virtual FIFO_inf.MONITOR_WR inf;

    function new(string name = "FIFO_wr_monitor", uvm_component parent);
 
        super.new(name,parent);
 
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        mon_wr = new("mon_wr",this);

        if(!uvm_config_db#(virtual FIFO_inf.MONITOR_WR) :: get(this,"*","inf",inf))

            `uvm_fatal("NOINF","Interface not found")
      
    endfunction

    task run_phase(uvm_phase phase);

        FIFO_wr_item wr_itm;

        forever begin

            @(inf.mon_cb_wr);

            if (inf.mon_cb_wr.wr_en && !inf.mon_cb_wr.full) begin

                    wr_itm = FIFO_wr_item :: type_id :: create("wr_itm",this);

                    wr_itm.data_in = inf.mon_cb_wr.data_in;
                    wr_itm.full = inf.mon_cb_wr.full;
                    wr_itm.wr_en = inf.mon_cb_wr.wr_en;

                    `uvm_info(get_type_name(),$sformatf("data_in = %0d | full = %0d | wr_en = %0d",wr_itm.data_in,wr_itm.full,wr_itm.wr_en),UVM_HIGH)

                    mon_wr.write(wr_itm);

                end

            end
      
    endtask
  
endclass