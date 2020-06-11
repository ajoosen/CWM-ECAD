//////////////////////////////////////////////////////////////////////////////////
// Exercise #7
// Student Name: Artjom Joosen
// Date: 11.06.2020
//
//  Description: In this exercise, you need to implement a times table of 0..7x0..7
//  using a memory.
//
//  inputs:
//           clk, a[2:0], b[2:0], read
//
//  outputs:
//           result[4:0]
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module multiplication_table (
	input clk,
	input [2:0] a,
	input [2:0] b,
	input enable,
	output wire [5:0] result
	);

	multiply_bram multiply_ip (.clka(clk), .ena(enable), .wea(0), .addra({a,b}), .dina(0), .douta(result) );

endmodule
