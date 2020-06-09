//////////////////////////////////////////////////////////////////////////////////
// Exercise #4 
// Student Name: Artjom Joosen
// Date: 09.06.2020
//
//  Description: In this exercise, you need to design an electronic dice, following
//  the diagram provided in the exercises documentation. The dice rolls as long as
//  a button is pressed, and stops when it is released. 
//
//  inputs:
//           clk, rst, button
//
//  outputs:
//           throw [2:0]
//
//  You need to write the whole file.
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module dice(
 	//Todo: define inputs here
    	input rst,
    	input clk,
    	input button,
    	output reg [2:0] throw
    	);


//Use a sequential (clocked) always block and if-else conditions or the case command.
	    always @(posedge clk) begin
			//accounts for 2 cases on LHS of chart (next state independent of button)
			if (rst)
			   throw <= 3'b000;

			else begin
			if ((throw == 3'b000) | (throw == 3'b111))
		    	   throw <= 3'b001;

		//counting upwards 
		if (throw < 3'b110)
				throw <= throw + button;

			else
				throw <= button ? 3'b001 : throw;

			end
		end

endmodule

