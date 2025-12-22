class scoreboard #(parameter int width);

  //local sb_mbx
  mailbox sb_mbx;
  
  //function constructor to point the same memory as global mon_sb mbx 
  function new(mailbox mon_sb);
    sb_mbx=mon_sb;
  endfunction
   
 
  //for self_checking to store the exp_output:
  bit [width-1:0] exp_q;

  function void check (base_transaction #(width)sb_tr );
     
     if (sb_tr.rst)
       exp_q='0;
     else begin
       if (sb_tr.en)
         exp_q++;
       else 
         exp_q--;
     end
     
 
     if (sb_tr.q==exp_q)
       $display("----------pass---------");
     else 
       $display("---------fail---------");
   endfunction     
       

  //task to get and check the output with calculated exp output 
  task sb_task();
    base_transaction #(width) sb_tr;
    repeat (12) begin
      sb_mbx.get(sb_tr);
      sb_tr.display("signals received on score board");
      //call function to campare the exp output to dut output
      check(sb_tr);
      $display("-------------------------------------------------");
      
      end
  endtask
endclass
