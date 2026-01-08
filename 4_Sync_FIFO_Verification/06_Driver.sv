class driver#(parameter int width,parameter int depth);

  //create virtual interface to drive the signal to global interface
  virtual intf #(width,depth)vif;
  
  //local driv_mbx
  mailbox driv_mbx;
  
  
  //function constructor to point the same memoer as global gen_driv mbx and interface
  function new(mailbox gen_driv,virtual intf #(width,depth) vif);
    driv_mbx=gen_driv;
    this.vif=vif;
    
  endfunction
  
  
  //task for get the data from mbx and drive to interface through virtual interface
  
  task driver_task();
    vif.rst=1;
    #20;
    vif.rst=0;
    
    repeat(40) begin
      transaction #(width)tr;
      //tr = transaction #(this.width)::new();
      driv_mbx.get(tr);
      @(negedge vif.clk);
      vif.w_en=tr.w_en;
      vif.r_en=tr.r_en;
      vif.data_in=tr.data_in; 
      tr.display("driver signal");
      
    end
  endtask
endclass
