`include "interface.sv"
`include "test.sv"

module d_tb;
  logic clk;
 
  
  
  intf intf_tb(); 
  //pass the interface handle to test 
  test obj (intf_tb);
  
  //dut 
  d_ff dut (.clk(intf_tb.clk),
            .rst(intf_tb.rst),
            .d(intf_tb.d),
            .q_out(intf_tb.q));
  
  
  //clk generation
  initial begin
    intf_tb.clk=0;
    forever #5 intf_tb.clk=~intf_tb.clk;
  end
  

//end simulation time  
initial #150 $finish;
    
endmodule
    

  
