`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"


class environment #(parameter int width,parameter int depth);
  //creating object for all submodule classes
  generator #(width) gen;
  driver #(width,depth) driv;
  //dut
  monitor #(width,depth) mon;
  scoreboard #(width) s_b;
  
  
//create mailbox for transfer the transaction data object from generator to driver
  mailbox gen_driv;
  
//another mailbox for interprocess communication btween monitor to  scoreboard
  mailbox mon_sb;
  
  //assign physical interface handle to local virtual interface by constructor
  virtual intf #(width,depth)vif;
  function new(virtual intf #(width,depth) vif);
    vif=vif;
    
    
    //maillbox memory creation
    gen_driv=new();
    mon_sb  =new();
    
    //handle the global mailbox memory to sub module mailbox using constructor function
    gen = new(gen_driv);
    driv=new(gen_driv,vif);
    mon=new(mon_sb,vif);
    s_b=new(mon_sb);
    
  endfunction 
    
    task drivedata();
      //calling each task concurrently
      fork 
        gen.gen_task();
        driv.driver_task();
        mon.monitor_task();
        s_b.sb_task();
      join
      
    endtask
endclass
