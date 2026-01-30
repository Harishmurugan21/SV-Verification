class coverage;
  //local mailbox
  mailbox mon_cvg;
  
  event cover_done;
  
  transaction tr;
  
  covergroup c;
   coverpoint tr.a;
   coverpoint tr.b;
   coverpoint tr.c;
    
    cross tr.a,tr.b,tr.c;
  endgroup
  
  
  //constructor:
  function new(mailbox mon_cvg,event cover_done);
    this.mon_cvg=mon_cvg;
    this.cover_done=cover_done;
    c=new();
  endfunction
  
  //task
  task cvg_task();
    forever begin
      mon_cvg.get(tr);
      //to hit the coverage varibles
      c.sample();
      $display("Coverage = %0.2f %%", c.get_coverage());
      if(c.get_coverage()==100)begin
        $display("<<-------100%% coverbins hitted------->>");
        //break;
        ->cover_done;
      end
    end
     
  endtask
  
endclass
      
  
   
  
  
   
  
