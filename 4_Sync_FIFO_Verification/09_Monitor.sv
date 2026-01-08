class monitor # (parameter int width,parameter int depth);
  //int width;
  //create virtual interface to get the signal to global interface
  virtual intf #(width,depth) vif;
  
  //local mon_mbx
  mailbox mon_mbx;
  
  
  //function constructor to point the same memory as global mon_sb mbx and interface
  function new(mailbox mon_sb,virtual intf #(width,depth) vif);
    mon_mbx=mon_sb;
    this.vif=vif;
    
  endfunction
  
  //task to monitor the data from global interface and put into mon_sb mbx
  
  task monitor_task();
    transaction #(width) tr;
    repeat (40)begin
      @(posedge vif.clk);
      #1; //delay for safe process 
      tr = transaction #(this.width)::new();
      tr.rst=vif.rst;
      tr.w_en = vif.w_en;
      tr.r_en = vif.r_en;
      tr.data_in = vif.data_in;
      tr.data_out = vif.data_out;
      tr.empty = vif.empty;
      tr.full=vif.full;
      
      mon_mbx.put(tr);
      
      tr.monitor_display("monitor class signals");
    end
    
  endtask
endclass
      
    
