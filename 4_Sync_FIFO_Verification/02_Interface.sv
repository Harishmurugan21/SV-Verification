interface intf #(parameter int width, parameter int depth);
  
  logic clk;
  logic rst;
  logic w_en,r_en;
  logic [width-1:0]data_in;
  logic [width-1:0]data_out;
  logic empty;
  logic full;

  //drives to dut
  clocking driv_cb @(posedge clk);
    default output #1;
    output rst;
    output w_en; 
    output r_en;
    output data_in;
  endclocking

  //sampling from dut 
  clocking mon_cb @(posedge clk);
    default input #0;
    input rst;
    input w_en;
    input r_en;
    input data_in;
    input data_out;
    input empty;
    input full;
  endclocking

endinterface
