class generator #(parameter int width);
  //object creation for transaction class
  //transaction tr;
  
  //local mailbox to put the generator transation data object
  mailbox gen_mbx;
  int mode;
  
  //function for local gen_mbx to point the same memory as global mbx 
  function new(mailbox gen_driv,int mode);
    gen_mbx=gen_driv;
    this.mode=mode;
    
  endfunction
    

    task gen_task();
      base_transaction #(width) tr;
      up_transaction #(width) tr1;
      down_transaction #(width) tr2;

      repeat (10) begin
        if (mode)begin
          tr1=new(); 
          tr =tr1;
        end
        
      else begin
        
        tr2=new();
        tr = tr2;
      end

      tr.set_mode();
      tr.display("generatd class signal");
      gen_mbx.put(tr);
      
    end
      
      $display("-------------------------------------------");
  endtask

endclass
      
      
      
      
      
        
        

      
    
      
