//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #5 - Traffic Lights
// Student Name: Artjom Joosen
// Date: 09/06/2020
//
// Description: A testbench module to test Ex5 - Traffic Lights
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
    );
    

//Todo: Parameters
    parameter CLK_PERIOD = 10;

//Todo: Registers and wires
    reg clk;
    reg [2:0] previous_rag_state;
    wire red;
    wire amber;
    wire green;
    reg err;


//Todo: Clock generation
    initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end
    
 //Todo: User logic
	initial begin
       	err=0;
	previous_rag_state = {red,amber,green};	   
    	clk = 0;

	#CLK_PERIOD;
	forever begin
		previous_rag_state = {red,amber,green};	   
		
		//check for forbidden states
		#CLK_PERIOD if ((red==1'b0 && amber==1'b0 && green==1'b0) || (red==1'b1 && amber==1'b0 && green==1'b1) || (red==1'b1 && amber==1'b1 && green==1'b1) || (red==1'b0 && amber==1'b1 && green==1'b1)) 
			begin
   	   		   $display("Error! forbidden state!");
   	   		   err=1;
       			end

		if (previous_rag_state=={red,amber,green})
			begin
   	   		   $display("Error! State not incremented!");
   	   		   err=1;
       		        end	
		end
	end

//Todo: Finish test, check for success
      initial begin
        #100 if (err==0)
          $display("***TEST PASSED! :) ***");
        $finish;
      end


//User's module
    traffic_lights_top top (.clk(clk), .red(red), .amber(amber), .green(green) );
     
endmodule
