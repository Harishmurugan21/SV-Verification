`include "synhrononizer.sv"
module async_fifo #(parameter fifo_width=8,fifo_depth=32)(
    input  logic        wr_clk,
    input  logic        wr_rst,   // write domain reset

    input  logic        rd_clk,
    input  logic        rd_rst,   // read domain reset

    input  logic        w_en,
  input  logic [fifo_width-1:0]  data_in,
    input  logic        r_en,
  output logic [fifo_width-1:0]  data_out,

    output logic full,
    output logic empty
);

//register file file creation
  logic [fifo_width-1:0] fifo [fifo_depth-1:0];     //32 bytes;
  
localparam pntr_width=$clog2(fifo_depth);  

//fifo address write and read pointer ;
  logic [pntr_width:0] w_pntr,r_pntr;
  
  logic [pntr_width:0] w_pntr_grey,r_pntr_grey;
  //sync output
  logic [pntr_width:0] w_pntr_rsync_g,r_pntr_wsync_g;
  //convert to binary
  logic [pntr_width:0] w_pntr_rsync_b,r_pntr_wsync_b;
  
  
  always_comb
    begin
      w_pntr_grey=bin_grey(w_pntr);
    end
  always_comb
    begin
      r_pntr_grey=bin_grey(r_pntr);
    end
    

//write to fifo
  always_ff @ (posedge wr_clk)begin
    if (wr_rst)
      begin
                w_pntr<=0;
      			//w_pntr_grey<=0;
      end
    			
        else begin
          if  (w_en&&(!full))begin
                fifo[w_pntr]<=data_in;
                w_pntr<=w_pntr+1;
            //w_pntr_grey<=bin_grey(w_pntr);
            
        end
        end

end


//read from fifo
  always_ff @ (posedge rd_clk)begin
    if (rd_rst)begin
                r_pntr<=0;
      			//r_pntr_grey<=0;
                data_out<=0;
        end
        else begin
          if (r_en&&(!empty))begin
                data_out<=fifo[r_pntr];
                r_pntr<=r_pntr+1;
            //r_pntr_grey<=bin_grey(r_pntr);
            
        end
        end

end
  
  //binary to grey convertor
  function automatic logic [pntr_width:0] bin_grey (input bit [pntr_width:0]bin);
    bin_grey=(bin>>1)^bin;
  endfunction
  
  //grey to binary back convertor
  function automatic logic [pntr_width:0] grey_bin (input bit [pntr_width:0]grey);
    bit [pntr_width:0]temp_bin;
    begin
      temp_bin[pntr_width]=grey[pntr_width];
      for(int i=pntr_width-1;i>=0;i--)begin
        temp_bin[i]=grey[i]^temp_bin[i+1];
      end
      grey_bin=temp_bin;
    end
  endfunction
  
  
 //synchronize r_pntr with respect w_clk to check the full status
  synchronizer #(pntr_width) rpntr_cdc_w (
    wr_clk,wr_rst,
    r_pntr_grey,
    r_pntr_wsync_g);
  
  always_comb r_pntr_wsync_b=grey_bin(r_pntr_wsync_g);
  
  
  //synchronize the w_pntr to read clk domain to check the empty
  
  synchronizer #(pntr_width) wpntr_cdc_r(
    rd_clk,rd_rst,
    w_pntr_grey,
    w_pntr_rsync_g);
 
  always_comb w_pntr_rsync_b=grey_bin(w_pntr_rsync_g);
  
  
  
  
  //async fifo empty status comparing synchronized w_pntr to r_pntr
  
  assign empty=(w_pntr_rsync_b==r_pntr);
  
  //async fifo full status comparing synchronized r_pntr to w_pntr
  
  assign full=((w_pntr[pntr_width-1]==r_pntr_wsync_b[pntr_width-1])&&(w_pntr[pntr_width]!=r_pntr_wsync_b[pntr_width]));
  
  
endmodule
  

  
  
      
  
  
  
  
  
  
  
