package FIFO_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "FIFO_wr_item.sv"
    `include "FIFO_rd_item.sv"
    `include "FIFO_wr_sequencer.sv"
    `include "FIFO_rd_sequencer.sv"
    `include "FIFO_virtual_sequencer.sv"
    `include "FIFO_wr_seq.sv"
    `include "FIFO_rd_seq.sv"
    `include "FIFO_virtual_sequence.sv"
    `include "FIFO_wr_driver.sv"
    `include "FIFO_rd_driver.sv"
    `include "FIFO_wr_monitor.sv"
    `include "FIFO_rd_monitor.sv"
    `include "FIFO_wr_agent.sv"
    `include "FIFO_rd_agent.sv"
    `include "FIFO_scoreboard.sv"
    `include "FIFO_wr_coverage.sv"
    `include "FIFO_rd_coverage.sv"
    `include "FIFO_env.sv"
    `include "FIFO_test.sv"

endpackage