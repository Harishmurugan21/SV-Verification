module sync_fifo #(parameter fifo_width=8,fifo_depth=32)(
        input logic clk,rst,w_en,r_en,
  
  input logic [fifo_width-1:0]data_in,
  output  logic [fifo_width-1:0]data_out,
  
        output logic empty,full);



//register file file creation
logic [fifo_width-1:0] fifo [fifo_depth-1:0];     //32 bytes;
  
localparam pntr_width=$clog2(fifo_depth);  

//fifo address write and read pointer ;
logic [pntr_width-1:0] w_pntr,r_pntr;

//write to fifo
always_ff @ (posedge clk)begin
        if (rst)
                w_pntr<=0;
        else begin
          if  (w_en&&(!full))begin
                fifo[w_pntr]<=data_in;
                w_pntr<=w_pntr+1;
        end
        end

end


//read from fifo
always_ff @ (posedge clk)begin
        if (rst)begin
                r_pntr<=0;
                data_out<=0;
        end
        else begin
          if (r_en&&(!empty))begin
                data_out<=fifo[r_pntr];
                r_pntr<=r_pntr+1;
        end
        end

end
  

//empty logic for read pointer
assign empty=(r_pntr==w_pntr);


//full logic for write pointer
  assign full=((w_pntr+1)==r_pntr);
  
  
  //n+1 logic;
  //100% percent efficient ,no memory waste;
  //((w_pntr[pntr_width-1]==r_pntr[pntr_width-1])&&(w_pntr[pntr_width]!=r_pntr[pntr_width]));
  //Address bits match, but the MSBs bit are different.
  



endmodule


        
  
