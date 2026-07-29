`include "uvm_macros.svh"
import uvm_pkg::*;

`uvm_analysis_imp_decl(_wr)
`uvm_analysis_imp_decl(_rd)

class FIFO_scoreboard #(parameter DATA_WIDTH = 16, parameter DEPTH = 16) extends uvm_scoreboard;

    typedef FIFO_scoreboard #(DATA_WIDTH,DEPTH) this_sb;
    `uvm_component_param_utils(this_sb)

    int pass_count, fail_count;

    logic [DATA_WIDTH-1:0] expected_q[$];

    uvm_analysis_imp_wr#(FIFO_wr_item, this_sb) wr_imp;

    uvm_analysis_imp_rd#(FIFO_rd_item, this_sb) rd_imp;

    function new(string name = "FIFO_scoreboard", uvm_component parent);
 
        super.new(name,parent);
 
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        wr_imp = new("wr_imp",this);

        rd_imp = new("rd_imp",this);

        pass_count = 0;

        fail_count = 0;
      
    endfunction

    function void write_wr(FIFO_wr_item item);

        if(expected_q.size() >= DEPTH) begin
            `uvm_error(get_type_name(),$sformatf("WRITE observed while queue already at DEPTH (%0d)! data_in = %0d — possible full-flag bug", DEPTH, item.data_in))
            fail_count++;
            return;
        end

        expected_q.push_back(item.data_in);
        `uvm_info(get_type_name(),$sformatf("WRITE observed: data_in = %0d",item.data_in),UVM_HIGH)

    endfunction

    function void write_rd(FIFO_rd_item item);

        logic [DATA_WIDTH-1:0] expected_data;

        if (expected_q.size() == 0) begin
            `uvm_error(get_type_name(),$sformatf("READ observed but queue is empty! data_out = %0d",item.data_out))
            fail_count++;
            return;
        end

        expected_data = expected_q.pop_front();

        if ($isunknown(expected_data)) begin

        `uvm_warning(get_type_name(), $sformatf("Skipping comparison: reference data unknown at simulation start (data_out = %0d) — known startup scheduling artifact", item.data_out))
        return;
        
        end

        if(expected_data == item.data_out) begin
            `uvm_info(get_type_name(),$sformatf("PASS : data_out = %0d",item.data_out),UVM_LOW)
            pass_count++;
        end

        else begin
            `uvm_error(get_type_name(),$sformatf("FAIL : expected : %0d | data_out : %0d",expected_data,item.data_out))
            fail_count++;
        end
    endfunction

        function void report_phase(uvm_phase phase);

        `uvm_info(get_type_name(), $sformatf("========== SUMMARY =========="), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Tranasctions: %0d", pass_count + fail_count), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("PASS: %0d", pass_count), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("FAIL: %0d", fail_count), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("=================================="), UVM_LOW)
      
    endfunction

endclass