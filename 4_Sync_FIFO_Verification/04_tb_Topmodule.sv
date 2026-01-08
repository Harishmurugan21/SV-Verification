//testbench
`include "interface.sv"
`include "test.sv"
module tb;
  
  parameter W=8;
  parameter D=8;
  
  
  //create handle for interface
  intf #(.width(W), .depth(D)) intf_tb();
  //pass the interface handle to test environment
  test #(W,D) name;
  
  initial begin
    name=new(intf_tb);
    name.test();
  end
  
  
  //dut 
  
  sync_fifo  #(W,D) dut (.clk(intf_tb.clk),
                        .rst(intf_tb.rst),
                        .w_en(intf_tb.w_en),
                        .r_en(intf_tb.r_en),
                        .data_in(intf_tb.data_in),
                        .data_out(intf_tb.data_out),
                        .full(intf_tb.full),
                        .empty(intf_tb.empty));
  
  initial begin
    intf_tb.clk=0;
    forever #5 intf_tb.clk=~intf_tb.clk;
  end
  
  
  
    
  //end sumulation time
  initial #600 $finish;

  
endmodule
  
  
  
