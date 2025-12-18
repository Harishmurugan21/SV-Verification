`include "environment.sv"
//top module
//we can allowed to pass the physical interface directly to program block both interface and program /module blk are static
program test (intf intf_tb);
  
  //create object for environment class
  environment env;
  initial begin
    //assign interface handle to environment
    env=new(intf_tb);
    env.drivedata();
  end
  
  
endprogram
