class monitor #(parameter int width);
  
  //int width;
  //create virtual interface to get the signal to global interface
  virtual intf #(width) vif;
  
  //local mon_mbx
  mailbox mon_mbx;
  
  
  //function constructor to point the same memory as global mon_sb mbx and interface
  function new (mailbox mon_sb,virtual intf #(width) vif);
    mon_mbx=mon_sb;
    this.vif=vif;
    
  endfunction
  
  //task to monitor the data from global interface and put into mon_sb mbx
  
  task monitor_task();
    base_transaction #(width) t;
    up_transaction #(width) tr1;
    down_transaction #(width)tr2;
    repeat (12)begin
      @(posedge vif.clk);
      #1; //delay for safe process 
      
      if (vif.en)begin
        tr1=new();
        t=tr1;
      end
      else begin
        tr2=new();
        t=tr2;
      end
      
      t.rst=vif.rst;
      t.en=vif.en;
      t.q=vif.q;
      mon_mbx.put(t);

      t.display("monitor class signals");
    end
    
  endtask
endclass
      
    
