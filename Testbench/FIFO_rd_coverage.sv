
class FIFO_rd_coverage #(parameter DATA_WIDTH = 16) extends uvm_subscriber#(FIFO_rd_item);

    typedef FIFO_rd_coverage #(DATA_WIDTH) this_cov;
    `uvm_component_param_utils(this_cov)

    FIFO_rd_item rd_itm;

    function new(string name = "FIFO_rd_coverage", uvm_component parent);
 
        super.new(name,parent);

        FIFO_rd_cg = new();
 
    endfunction

    covergroup FIFO_rd_cg;

        rd_en_cp : coverpoint rd_itm.rd_en;
        empty_cp : coverpoint rd_itm.is_empty;
        FIFO_cross : cross rd_en_cp , empty_cp;

    endgroup

    function void write(FIFO_rd_item t);

        rd_itm = t;
        FIFO_rd_cg.sample();
      
    endfunction

    function void report_phase(uvm_phase phase);

        `uvm_info(get_type_name(),$sformatf("Total coverage:%0.2f",FIFO_rd_cg.get_coverage()),UVM_LOW)
      
    endfunction
  
endclass