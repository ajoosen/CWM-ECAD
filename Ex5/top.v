//////////////////////////////////////////////////////////////////////////////////
// Exercise #5 
// Student Name: Artjom Joosen
// Date: 10.06.2020
//
//  Description: In this exercise, you need to implement a UK traffic lights 
//  sequencing system. 
//
//  inputs:
//           clk
//
//  outputs:
//           red, amber, green
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module traffic_lights_top(
    //Todo: define inputs here
    input clk,
    output reg red,
    output reg amber,
    output reg green

    );

	    always@(posedge clk)
			//if the state is valid
		    if   ( (red==1'b0 && amber==1'b0 && green==1'b0) || (red==1'b1 && amber==1'b0 && green==1'b1) || (red==1'b0 && amber==1'b1 && green==1'b1) || (red==1'b1 && amber==1'b1 && green==1'b1) ) 
			    begin       //start with red and goes clockwise around state graph
				red <= 1'b1;
				amber <= 1'b0;
				green <= 1'b0;
			    end else 
			    if(red==1'b1 && amber==1'b0 && green==1'b0)
			    begin
				red <= 1'b1;
				amber <= 1'b1;
				green <= 1'b0;
			    end else 
                            if(red==1'b1 && amber==1'b1 && green==1'b0)
		            begin
				red <= 1'b0;
				amber <= 1'b0;
				green <= 1'b1;
			    end else 
			    if(red==1'b0 && amber==1'b0 && green==1'b1)
		            begin
				red <= 1'b0;
				amber <= 1'b1;
				green <= 1'b0;
			    end 
		    else //accounts for non-valid states -- will just go to initial state (rag == 100)
                    begin
			red <= 1'b1;
			amber <= 1'b0;
			green <= 1'b0;
		    end

endmodule

