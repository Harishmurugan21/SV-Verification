module full_adder(input a,b,c,output sum,carry);

  assign sum = (a^b^c);
  assign carry = ((a&b)|(b&c)|(c&a));
  

  //gatelevel modelling 
  
//     wire c1,c2,c3;
//   xor x1(sum,a,b,c);
//   and a1(c1,a,b);
//   and a2(c2,b,c);
//   and a3(c3,c,a);
//   or o1(carry,c1,c2,c3);
endmodule
  
