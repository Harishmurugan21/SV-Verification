interface intf ();
  
  logic clk;
  logic rst;
  logic d;
  logic q;
  
  
  clocking driv_cb @(posedge clk);
    
    //default it contain #1 delay 
    //driven by the driver 
    output   d;
    output   rst;  //optional for synchronous reset;
    
    //sample by moniter from interface
    input   q;
    
  endclocking
  
  clocking mon_cb @(posedge clk);
    input rst;
    input d;
    input q;
  endclocking
  
endinterface
  
    
