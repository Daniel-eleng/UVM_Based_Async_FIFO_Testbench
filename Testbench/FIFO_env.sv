`include "uvm_macros.svh"
import uvm_pkg::*;

class FIFO_env extends uvm_env;

    `uvm_component_utils(FIFO_env)

    FIFO_scoreboard #(16,16) scrb;

    FIFO_wr_agent wr_agn;

    FIFO_rd_agent rd_agn;

    FIFO_wr_coverage #(16) wr_cov;

    FIFO_rd_coverage #(16) rd_cov;

    function new(string name = "FIFO_env", uvm_component parent);
 
        super.new(name,parent);
 
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        scrb = FIFO_scoreboard#(16,16) :: type_id :: create("scrb",this);

        wr_agn = FIFO_wr_agent :: type_id :: create("wr_agn",this);

        rd_agn = FIFO_rd_agent :: type_id :: create("rd_agn",this);

        wr_cov = FIFO_wr_coverage#(16) :: type_id :: create("wr_cov",this);

        rd_cov = FIFO_rd_coverage#(16) :: type_id :: create("rd_cov",this);
      
    endfunction

    function void connect_phase(uvm_phase phase);

        super.connect_phase(phase);

        wr_agn.wr_mon.mon_wr.connect(scrb.wr_imp);

        wr_agn.wr_mon.mon_wr.connect(wr_cov.analysis_export);

        rd_agn.rd_mon.mon_rd.connect(scrb.rd_imp);

        rd_agn.rd_mon.mon_rd.connect(rd_cov.analysis_export);
      
    endfunction
  
endclass