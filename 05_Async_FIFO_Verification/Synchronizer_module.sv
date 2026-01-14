module synchronizer #(parameter pntr) (
  input logic clk,rst,
  input logic [pntr:0] async_grey,
  output logic [pntr:0] sync_grey);
  
  logic [pntr:0]q1,q2;//2_ff method
  
  always @(posedge clk or posedge rst)begin
    if (rst)begin
      q1<=0;
      q2<=0;
    end
    else 
      begin
        q1<=async_grey;
        q2<=q1;
      end
    assign sync_grey=q2;
  end
  
  
endmodule
 
  
  
      
    
  
