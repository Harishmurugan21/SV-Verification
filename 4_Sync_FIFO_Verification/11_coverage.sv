class coverage;
  transaction tr;
  
  mailbox mon_cvg;
  //to stop after require coverbins hitted;
  event cover_done;

  
  covergroup c;
    coverpoint tr.empty;
    coverpoint tr.full;
   // coverpoint tr.r_en;
   // coverpoint tr.w_en;
    
    //state_coverage;
    coverpoint {tr.empty, tr.full} {
      bins partial = {2'b00};  // Both false
      bins empty   = {2'b10};  // empty=1, full=0  
      bins full    = {2'b01};  // empty=0, full=1    
      illegal_bins invalid = {2'b11}; } // Both true
    
    //simultaneous operation  coverage.
    coverpoint {tr.r_en,tr.w_en}{
       bins simulatenous={2'b11};}

      
  
    //coverpoint tr.rst iff(!tr.empty&&!tr.full);
    //cross tr.w_en,tr.r_en iff (!tr.empty && !tr.full);//in partial state:
   
    
    //in partial state  +operation coverage.
    coverpoint tr.r_en {  
       bins rd_inpartial={1} iff(!tr.empty && !tr.full);
       bins read_active = {1};
       bins read_idle = {0};
      ignore_bins r_when_empty = {1} iff (tr.empty);}
    coverpoint tr.w_en {
       bins wr_inpartial={1} iff(!tr.empty && !tr.full);
       bins wr_active = {1};
       bins wr_idle = {0};
      ignore_bins w_when_full = {1} iff (tr.full);}
    
    //reset_coverage
    //coverpoint tr.rst{
     //bins rreset={1};
     //bins rst_inpartial ={1} iff (!tr.empty && !tr.full);}
      
 
    
  endgroup
  
  
    
  function new(mailbox mon_cvg,event cover_done);
    this.mon_cvg=mon_cvg;
    this.cover_done=cover_done;
    c=new();
  endfunction
  
  task run_cvg;
    forever begin
      mon_cvg.get(tr);
      c.sample();
      $display("Coverage = %0.2f %%", c.get_coverage());
      $display("");
      $display("Next transaction");
      
      if(c.get_coverage()>=95)begin
        $display("100%% coverbins Hitted");
        ->cover_done;
        //break;
      end
    end
  endtask
  
endclass

    /*coverpoint r_en iff(tr.empty){
      bins r_empty ={1};}
    coverpoint w_en iff(tr.full){
      bins w_empty ={1};}
      
        
    //illegel bins
    cross tr.empty,tr.r_en{binsof r_when_empty={tr.empty&&tr.r_en};}
    cross tr.full,tr.w_en{binsof w_when_full={tr.full&&tr.w_en};} 
    
    coverpoint transition {bins lowtohigh =(tr.empty=>!tr.empty);
                          bins hightolow=(tr.full=>!tr.full);}
                           
    */
  
