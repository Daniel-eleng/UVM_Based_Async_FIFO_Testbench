
class FIFO_rd_coverage #(parameter DATA_WIDTH = 16) extends uvm_subscriber#(FIFO_rd_item);

    typedef FIFO_rd_coverage #(DATA_WIDTH) this_cov;
    `uvm_component_param_utils(this_cov)

    bit seen_read_notempty;
    bit seen_read_empty;

    function new(string name = "FIFO_rd_coverage", uvm_component parent);
 
        super.new(name,parent);
 
    endfunction

    function void write(FIFO_rd_item item);

        if (item.rd_en && !item.is_empty && !seen_read_notempty) begin
            seen_read_notempty = 1;
            `uvm_info(get_type_name(), "First occurrence: read while NOT empty", UVM_LOW)
        end

        if (item.rd_en && item.is_empty && !seen_read_empty) begin
            seen_read_empty = 1;
            `uvm_info(get_type_name(), "First occurrence: read attempted while EMPTY", UVM_LOW)
        end

    endfunction
  
endclass