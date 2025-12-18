//transaction class 
class transaction;
  
  rand bit rst;
  rand bit d;
       bit q;
  

  //display method to track transaction data object;
  function void display (string name);
     $display("%s",name);
    $display("$time=%0t| rst=%b | d=%b | q=%b |",$time,rst,d,q);
  endfunction
  
endclass
  	 
