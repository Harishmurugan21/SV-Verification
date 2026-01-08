class transaction #(parameter int width=8);
  
//   function new(int width,int depth);
//     this.width=width;
//     this.depth=depth;
//   endfunction
     
  
   bit rst;
  
  rand bit w_en;
  rand bit r_en;
  rand bit [width-1:0]data_in;
  bit [width-1:0]data_out;
  bit full;
  bit empty;
  
  constraint simple_access_c {
        // Data_in is only random when writing is enabled, otherwise set it to 0
    w_en -> data_in inside {[0 : (1 << width) - 1]}; 
        !w_en -> data_in == 0;
    
    }
  constraint bias_c {
        // Bias W_EN: 
        // W_EN=1 (asserted) is 70% likely (weight := 70)
        // W_EN=0 (de-asserted) is 30% likely (weight := 30)
    w_en dist { 1 := 80, 0 := 20 };
        
        // Bias R_EN:
        // R_EN=1 (asserted) is 30% likely (weight := 30)
        // R_EN=0 (de-asserted) is 70% likely (weight := 70)
    r_en dist { 1 := 20, 0 := 80 };
    }

  
  function  void display (string name);
    $display("%s",name);
    $display("$time=%0t | rst=%b| w_en=%b | r_en=%b | data_in=%b |",$time,rst,w_en,r_en,data_in);
  endfunction
  
  function void monitor_display(string name);
    
    $display("%s",name);
    $display("$time=%0t | rst=%b| w_en=%b | r_en=%b | data_in=%b |data_out=%b | empty=%b|full=%b | ",$time,rst,w_en,r_en,data_in,data_out,empty,full);
    
  endfunction
  
endclass
    
  
  
  
