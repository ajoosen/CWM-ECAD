//////////////////////////////////////////////////////////////////////////////////
// Exercise #9 
// Student Name: Artjom Joosen
// Date: 12.06.2020
//
//  Description: In this exercise, you need to design a module that lights leds
//  at different frequencies
//
//  inputs:
//           rst_n, clk_n, clk_p, button
//
//  outputs:
//           led_0, led_1, led_2
//////////////////////////////////////////////////////////////////////////////////


module top(
    input clk_p,
    input clk_n,

//Todo: everything other than clk_n and clk_p 
	input rst_n,	
	input button,
	output reg led_0,
	output reg led_1,
	output reg led_2
   );
    

/* clock infrastructure, do not modify */
        wire clk_ibufds;

    IBUFDS IBUFDS_sysclk (
	.I(clk_p),
	.IB(clk_n),
	.O(clk_ibufds)
);

     wire clk; //use this signal as a clock for your design
        
     BUFG bufg_clk (
	.I  (clk_ibufds),
	.O  (clk)
      );

//Add logic here
	reg [22:0] register;

	always @(posedge clk) 
		begin
		if ((rst_n == 0) | (button == 1'b1)) 
		begin
			led_0=0;
			led_1=0;
			led_2=0;
			register=0;
		end
		else 
		begin
			if (register == 21'b111111111111111111111) 
				led_0=~led_0;
			if (register == 22'b1111111111111111111111) 
				led_1=~led_1;
			if (register == 23'b11111111111111111111111) 
			begin
				led_2=~led_2;
				register=0;
			end
			else
				register=register+1;
		end

	end


endmodule
