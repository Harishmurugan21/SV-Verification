class scoreboard # (parameter int width);
  
  
  //local sb_mbx
  mailbox sb_mbx;
  
  
  //function constructor to point the same memory as global mon_sb mbx 
  function new(mailbox mon_sb);
    sb_mbx=mon_sb;
    
  endfunction
   
 
  //for self_checking
  logic [width-1:0] queue [$];
  bit [width-1:0] exp_data_out;
  
  //memory register 
   function void check (transaction sb_tr );
     //buffer queue;
     
     if (!sb_tr.rst&&sb_tr.w_en)
       queue.push_back(sb_tr.data_in);
     
     if (!sb_tr.rst&&sb_tr.r_en)
       exp_data_out=queue.pop_front();
     
     
     if (sb_tr.r_en==1)begin
       if(sb_tr.data_out==exp_data_out)begin
         $display("<---------pass--------->");
       end
       else 
         $display("<------fail-fifo_crashed------->");
     end
     
   endfunction     
       

  
  
  //task to get and check the output with calculated exp output
  
  task sb_task();
    transaction #(width) sb_tr;
    repeat (40) begin
      sb_mbx.get(sb_tr);
      sb_tr.monitor_display("signals received on score board");
      check(sb_tr);
      $display("-------------------------------------------------");
      //call function to campare the exp output to dut output
      
      //check(sb_tr);
    
       
      end
  endtask
endclass
