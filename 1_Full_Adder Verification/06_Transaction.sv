//transaction class 
class transaction;
  
  randc bit[2:0] in;//randc-->indicate no repetition untill all posisibles
  
   bit a;
   bit b;
   bit c;
  //output ports
   bit sum;
   bit carry;
  
  
  function void post_randomize();
    a=in[2];
    b=in[1];
    c=in[0];
  endfunction
  
  
  
  //display method to track transaction data object;
  function void display (string name);
     $display("%s",name);
    $display("a=%b,b=%b,c=%b,sum=%b,carry=%b",a,b,c,sum,carry);
  endfunction
  
endclass
  	 
   
