class driver #(parameter int width);

  //create virtual interface to drive the signal to global interface
  virtual intf #(width)vif;
  
  //local driv_mbx
  mailbox driv_mbx;
  
  
  //function constructor to point the same memoer as global gen_driv mbx and interface
  function new(mailbox gen_driv,virtual intf #(width) vif);
    this.vif=vif;
    driv_mbx=gen_driv;  
  endfunction
  
  
  //task for get the data from mbx and drive to interface through virtual interface 
  task driver_task();
    vif.rst=1;
    #20;
    vif.rst=0;    
  forever begin
      base_transaction #(width)tr;
      driv_mbx.get(tr);
      @(negedge vif.clk);
      vif.en <= tr.en;
      tr.display("driver class signal");
      
    end
  endtask

endclass
    

//driver class codes;
// driv_mbx.get(tr);
//       @(negedge vif.clk);
//       vif.w_en=tr.w_en;
//       vif.r_en=tr.r_en;
//       vif.data_in=tr.data_in; 
//       tr.display("driver signal");
