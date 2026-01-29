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
    forever begin
      transaction tr;
      driv_mbx.get(tr);
      vif.a=tr.a;
      vif.b=tr.b;
      vif.c=tr.c;
      
      tr.display("driver signal");
      #5;
    end
  endtask
endclass
    
  
  
  
  
