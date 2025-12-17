class scoreboard;

  //local sb_mbx
  mailbox sb_mbx;
  
  
  //function constructor to point the same memory as global mon_sb mbx 
  function new(mailbox mon_sb);
    sb_mbx=mon_sb;
    
  endfunction
  
  function void check (transaction sb_tr );
    logic exp_q;
    begin
      
      exp_q=(sb_tr.rst==1)?1'b0:sb_tr.d;
    
       
      if (sb_tr.q==exp_q)begin
        $display ("-------pass--------");
      end
        
    else
      $display ("--------fail---------");
      
    end
  endfunction
     
  
  
  //task to get and check the output with calculated exp output
  
  task sb_task();
    transaction sb_tr;
    repeat (15) begin
      sb_mbx.get(sb_tr);
      sb_tr.display("signals received on score board");
      
      
      //call function to campare the exp output to dut output
      
      check(sb_tr);
    
       
      end
  endtask
endclass
      
      
      
    
      
