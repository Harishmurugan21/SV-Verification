class generator;
  //object creation for transaction class
  transaction tr;
  transaction t;
  
  //local mailbox to put the generator transation data object
  mailbox gen_mbx;
  
  event e;
  
  //function for local gen_mbx to point the same memory as global mbx 
  function new(mailbox gen_driv,event e);
    gen_mbx=gen_driv;
    this.e=e;
    
  endfunction
    
    
    //task to randamixe the trnsaction data obj and put in the mbx
    task gen_task();
      tr=new();
      forever begin
        //allocat mem to transaction obj
        //tr=new();
      tr.randomize();
        t=new tr;
      gen_mbx.put(t);
        
      tr.display("generator class signal");
        @e;
      end
      
    endtask
    
    endclass
      
      
  
  
