
virtual class base_transaction #(parameter width );
  bit rst;
  logic [width-1:0]q;
  bit en;
  
  //pure virtual task;
  pure virtual task set_mode();
  
  virtual function void display(string name);
    $display("%0s",name);
    $display("time=%0t|rst=%b|en=%b| q=%0b|",$time,rst,en,q); 
   endfunction
    
endclass



//1st child class
    class up_transaction # (parameter width) extends base_transaction #(width);
      
  //bit en;
      
      
//       virtual intf  # (width) vif;
//       function new(virtual intf # (width) vif);
//         this.vif=vif;
//       endfunction
      
      task set_mode ();
        en=1;
      endtask

  function void display(string name);
    $display("%0s",name);
    $display("time=%0t|rst=%b| en=%b| q=%0b|",$time,rst,en,q);
  endfunction
      
endclass


//2nd child class
    class down_transaction # (parameter width) extends base_transaction #(width);
      
//       virtual intf #(width) vif;
//       function new(virtual intf #(width) vif);
//         this.vif=vif;
//       endfunction
      
      
      task set_mode ();
        en=0;
      endtask
   
  function void display(string name);
    $display("%0s",name);
    $display("time=%0t|rst=%b|en=%b| q=%0b|",$time,rst,en,q);
  endfunction
  
    
    endclass
  
  
  
  
 
    
    
    
    
    

      
      
      
      
      
      
      
      	
      
    	
     
    
