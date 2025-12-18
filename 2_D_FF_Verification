
module d_ff (input  logic clk,rst,d,output logic q_out);
  
  always_ff @(posedge clk or posedge rst)
    begin
      if (rst)
        q_out<=1'b0;
      else 
        q_out<=d;
    end
  
endmodule
        
    

  
