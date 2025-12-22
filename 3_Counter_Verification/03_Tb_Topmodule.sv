`include "interface.sv"
`include "environment.sv"

module counter_tb;
  
  parameter width=6;
  
  //paramter default data_type is int in sv;
  parameter mode=0;//1-->upcount
  				   //0-->downcopount
  

//create handle for interface
  intf #(width) intf_tb();
  
  environment #(width) env;

//pass the physical interfaca handle to environment
  initial begin
    env = new (intf_tb,mode);
    env.drivedata();
  end
  


//dut 
  counter #(.width(width)) dut (
    .clk(intf_tb.clk),
    .rst(intf_tb.rst),
    .en(intf_tb.en),
    .q(intf_tb.q));
  

  //clk generation
  initial begin
    intf_tb.clk=0;
    forever #5 intf_tb.clk=~intf_tb.clk;
  end
  

  //end simulation time
  initial begin
  #500;
  $finish;
  end

endmodule
  
  





