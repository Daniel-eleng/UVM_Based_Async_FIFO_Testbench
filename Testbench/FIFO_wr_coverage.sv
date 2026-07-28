
class FIFO_wr_coverage #(parameter DATA_WIDTH = 16) extends uvm_subscriber#(FIFO_wr_item);

    typedef FIFO_wr_coverage #(DATA_WIDTH) this_cov;
    `uvm_component_param_utils(this_cov)

    FIFO_wr_item wr_itm;

    function new(string name = "FIFO_wr_coverage", uvm_component parent);
 
        super.new(name,parent);

        FIFO_wr_cg = new();
 
    endfunction

    covergroup FIFO_wr_cg;

        data_in_cp : coverpoint wr_itm.data_in{
            bins zero = {0};
            bins max = {(1<<DATA_WIDTH) - 1};
            ignore_bins rest = default;
        }

        wr_en_cp : coverpoint wr_itm.wr_en;
        full_cp : coverpoint wr_itm.full;

        FIFO_cross : cross wr_en_cp , full_cp;
    endgroup

    function void write(FIFO_wr_item wr_item);

        wr_itm = wr_item;
        FIFO_wr_cg.sample();
      
    endfunction

    function void report_phase(uvm_phase phase);

        `uvm_info(get_type_name(),$sformatf("Total coverage:%0.2f",FIFO_wr_cg.get_coverage()),UVM_LOW)
      
    endfunction
  
endclass