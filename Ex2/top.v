//////////////////////////////////////////////////////////////////////////////////
// Exercise #2 
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to design a multiplexer, where the  
//  output acts according to the following truth table:
//
//  sel | out
// -----------------
//   0  | a
//   1  | b
//
//  inputs:
//           a, b, sel
//
//  outputs:
//           out
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module mux(
    //Todo: define inputs here
    reg a,
    reg b,
    input sel,
    input clock.
    
    output out
    );
    
    //Todo: define registers and wires here
    //wire   out;

    //Todo: define your logic here                 
  //  @(posedge clock or negedge clock)
   //     assign #5 out = a ? (sel==1'b0):
    //        b ? (sel==1'b1):
          //  default case
   //         2'b1;
    always@ (posedge clock or negedge clock) 
        if (~sel) 
            #5 out <= a; 
        else if (sel)
            #5 out <= b;
        end 

endmodule
