`include "environment.sv"
//top module
//we can allowed to pass the physical interface directly to program block both interface and program /module blk are static
class test #(parameter int width,parameter int depth);
  
  virtual intf #(width,depth) vif;
  function new (virtual intf #(width,depth)  vif);
    this.vif=vif;
  endfunction
  
  //create object for environment class
  environment # (width,depth) env;
  task test();
    //assign interface handle to environment
    env=new(vif);
    env.drivedata();
  endtask
  
  
  
endclass
