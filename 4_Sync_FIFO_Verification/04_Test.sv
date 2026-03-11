`include "environment.sv"

//we can allowed to pass the physical interface directly to program block both interface and program /module blk are static

class test #(parameter int width,parameter int depth);
  virtual intf #(width,depth) vif;
  environment # (width,depth) env;
  
  function new (virtual intf #(width,depth)  vif);
    this.vif=vif;
  endfunction
  
  task test();
    //create env obj and pass the V_intf via constructor
    env=new(vif);
    env.drivedata();
  endtask

endclass
