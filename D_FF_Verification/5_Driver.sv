class driver;
  //create virtual interface to drive the signal to global interface
  virtual intf vif;
  
  //local driv_mbx
  mailbox driv_mbx;
  
  
  //function constructor to point the same memoer as global gen_driv mbx and interface
  function new(mailbox gen_driv,virtual intf vif);
    driv_mbx=gen_driv;
    this.vif=vif;
    
  endfunction
  
  
  //task for get the data from mbx and drive to interface through virtual interface 
  task driver_task();
    
    repeat(15)begin
      transaction tr;
 
      driv_mbx.get(tr);
     
      // @(negedge vif.clk);
      @(vif.driv_cb);
      vif.driv_cb.rst<=tr.rst;
      vif.driv_cb.d<=tr.d;       
      tr.display("driver signal");
      
    end
    
  endtask
endclass
