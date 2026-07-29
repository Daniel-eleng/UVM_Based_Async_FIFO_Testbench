
class FIFO_wr_coverage extends uvm_subscriber#(FIFO_wr_item);

    `uvm_component_param_utils(FIFO_wr_coverage)

    bit seen_write_notfull;
    bit seen_write_full;

    function new(string name = "FIFO_wr_coverage", uvm_component parent);
 
        super.new(name,parent);
 
    endfunction

    function void write(FIFO_wr_item wr_itm);

        if (wr_itm.wr_en && !wr_itm.full && !seen_write_notfull) begin
            seen_write_notfull = 1;
            `uvm_info(get_type_name(), "First occurrence: write while NOT full", UVM_LOW)
        end

        if (wr_itm.wr_en && wr_itm.full && !seen_write_full) begin
            seen_write_full = 1;
            `uvm_info(get_type_name(), "First occurrence: write attempted while FULL", UVM_LOW)
        end

    endfunction
  
endclass