module counter #(parameter width)(
  input logic clk,
  input logic rst,
  input logic en,  	//1-->up,0--->down;
  output logic [width-1:0] q);
  
  
  
  always_ff @(posedge clk or posedge rst)begin
    if (rst)
      q<='0;
    else begin
      if (en)//up/down
        q<=q+1;
      else
        q<=q-1;
    end
    
  end
  
endmodule
    

  

  
  
  
