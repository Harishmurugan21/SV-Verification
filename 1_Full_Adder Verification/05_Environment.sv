`include "Transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "coverage.sv"


class environment;
  //creating object for all submodule classes
  generator gen;
  driver driv;
  //dut
  monitor mon;
  scoreboard s_b;
  //
  coverage cvg;
  event cover_done;
  event e;
  
  
//create mailbox for transfer the transaction data object from generator to driver
  mailbox gen_driv;
  
//another mailbox for interprocess communication btween monitor to  scoreboard
  mailbox mon_sb;
  
//mailbox for monitor and coverage  
  mailbox mon_cvg;
  
  //assign physical interface handle to local virtual interface by constructor
  virtual intf vif;
  function new(virtual intf intf_tb);
    vif=intf_tb;
    
    //maillbox memory creation
    gen_driv=new();
    mon_sb  =new();
    mon_cvg =new();
    
    //handle the global mailbox memory to sub module mailbox using constructor function
    gen=new(gen_driv,e);
    driv=new(gen_driv,vif);
    mon=new(mon_sb,mon_cvg,vif,e);
    s_b=new(mon_sb);
    cvg=new(mon_cvg,cover_done);
    
    
  endfunction
    
    task drivedata();
      //calling each task concurrently
      fork 
        gen.gen_task();
        driv.driver_task();
        mon.monitor_task();
        s_b.sb_task();
        cvg.cvg_task();
      join_none
      begin
      @cover_done;
        $finish;
      end      
      
    endtask
endclass
        
      
      
    
    
