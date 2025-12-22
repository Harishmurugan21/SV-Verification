//physical interface--->like bundle of port wires

interface intf #(parameter width);
  logic clk;
  logic rst;
  logic en;
  logic [width-1:0]q;

endinterface
