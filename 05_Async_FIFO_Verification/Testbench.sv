module async_fifo_tb ;
  
  parameter W=8;
  parameter D=32;
  
  logic wr_clk;
  logic wr_rst;
  logic w_en;
  logic [W-1:0] data_in;
  
  logic rd_clk;
  logic rd_rst;
  logic r_en;
  logic [W-1:0] data_out;
  
  logic empty,full;
  
  
  //dut 
  
  async_fifo #(W,D) dut (wr_clk,wr_rst,rd_clk,rd_rst,w_en,data_in,r_en,data_out,full,empty);
  
  
  //wr_clk generation
  initial begin
    wr_clk=0;
    forever #5 wr_clk=~wr_clk; //clk_period=10ns
  end
  
  
  //rd_clk generation
  initial begin
    rd_clk=0;
    forever #10 rd_clk=~rd_clk; //clk_period=20ns
  end
  
  
  initial begin
    $monitor ("$time=%0t |wr_clk=%b|wr_rst=%b | w_en=%b | data_in=%b |rd_clk=%b | rd_rst=%b | r_en=%b | data_out=%b | full=%b | empty=%b |",$time,wr_clk,wr_rst,w_en,data_in,rd_clk,rd_rst,r_en,data_out,full,empty);
  end
  
  
  initial begin
    //initialize the rst signal to make pointer zero;
    wr_rst=1;w_en=0;
    #15;
    wr_rst=0;//deassert the rst after make rd and wr poniter to zero;
    
    w_en=1;
    repeat (10) begin
      @(posedge wr_clk);
      data_in=$random;
    end
    
    w_en=0;
  end
  
  initial begin
    rd_rst=1;r_en=0;
    #15;
    rd_rst=0;//dearest rst
    
    repeat(8)begin
      @(posedge rd_clk);
      r_en=1;
    end
    r_en=0;
  end
  
  
  
  
  //end simulation;
  initial #100 $finish;
  
  
endmodule
  
    
      
    
      
    
  
  
  
  
  
