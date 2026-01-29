class monitor;
  //create virtual interface to get the signal to global interface
  virtual intf vif;
  
  //local mailbox
  
  mailbox mon_mbx;
  mailbox mon_cvg;
  
  event e;
  
  
  //function constructor to point the same memory as global mon_sb mbx and interface
  function new(mailbox mon_sb,mon_cvg,virtual intf vif,event e);
    mon_mbx=mon_sb;
    this.mon_cvg=mon_cvg;
    this.vif=vif;
    this.e=e;
    
  endfunction
  
  //task to monitor the data from global interface and put into mon_sb mbx
  
  task monitor_task();
    transaction tr;
    forever begin
      #1; //delay for safe process 
      tr=new();
      tr.a=vif.a;
      tr.b = vif.b;
      tr.c = vif.c;
      tr.sum = vif.sum;
      tr.carry = vif.carry;
      
      mon_mbx.put(tr);
      mon_cvg.put(tr);
      
      tr.display("monitor class signals");
      ->e;
      #4;
    end
    
  endtask
endclass
      
    
  
