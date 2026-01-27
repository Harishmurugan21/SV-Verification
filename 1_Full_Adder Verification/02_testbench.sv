
`include "interface.sv"
`include "test.sv"

module FA_tb;
  //create handle for interface
  intf intf_tb();
  //pass the interface handle to test environment
  test name (intf_tb);
  
  
  
  //dut connenct the interface handle to dut module
  full_adder dut (.a(intf_tb.a),
                  .b(intf_tb.b),
                  .c(intf_tb.c),
                  .sum(intf_tb.sum),
                  .carry(intf_tb.carry));
  
endmodule
  
