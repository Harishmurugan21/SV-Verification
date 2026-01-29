class scoreboard;
  
  logic sum_exp;
  logic carry_exp;

  
  //local sb_mbx
  mailbox sb_mbx;
  
  
  //function constructor to point the same memory as global mon_sb mbx 
  function new(mailbox mon_sb);
    sb_mbx=mon_sb;
    
  endfunction
  
  function void check (transaction sb_tr );
    int sum_exp;
    int carry_exp;
    begin
  
        sum_exp   = sb_tr.a ^ sb_tr.b ^ sb_tr.c;
       carry_exp = (sb_tr.a & sb_tr.b) | (sb_tr.b & sb_tr.c) | (sb_tr.c & sb_tr.a);

      
      if ((sum_exp == sb_tr.sum) && (carry_exp == sb_tr.carry))     
        $display ("--------pass-------");
      else
        $display("--------fail-------");
    end
  endfunction
     
  
  
  //task to get and check the output with calculated exp output
  
  task sb_task();
    transaction sb_tr;
    forever begin
      sb_mbx.get(sb_tr);
      sb_tr.display("signals received on score board");
      
      //call function to campare the exp output to dut output
      
      check(sb_tr);
    
       
      end
  endtask
endclass
      
      
      
    
