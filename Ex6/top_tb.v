//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #6 - Dice or Traffic Lights?
// Student Name: Artjom Joosen
// Date: 10.06.2020
//
// Description: A testbench module to test Ex6 - Dice or Traffic Lights?
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
    //Parameters
    parameter CLK_PERIOD = 10;

    //Registers and wires
	    reg clk;
	    reg sel;
	    reg rst;
	    wire [2:0] result;
    //dice 
	    reg err;
	    reg button;
	    reg [2:0] throw_previous_state;
	    wire [2:0] throw;
    //traffic lights
	    reg [2:0] rag_previous_state;
	    wire [2:0] rag;


    //Clock generation
    initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end
    
    //Todo: User logic
	initial begin
       	err=0; 
		rst = 1;
		sel = 0;
		button = 1;
		#10
		rst = 0;
       forever begin
       #CLK_PERIOD if ((sel == 0) & (result != throw_previous_state))
		begin
           		$display("***TEST FAILED! dice throw result not shown***");
           		err=1;
		end
		
		if ((sel == 1) & (result != rag_previous_state))
		begin
          		$display("***TEST FAILED! traffic light result not shown***");
           		err=1;
		end
		//update previous states
		throw_previous_state = throw;
		rag_previous_state = rag;
	end
	end

	initial begin
		#(CLK_PERIOD/2)forever begin
			//toggle select
			#(2*CLK_PERIOD)sel = ~sel;
		end
	end

//Todo: Finish test, check for success
      initial begin
        #500
        if (err==0)
          $display("***TEST PASSED! :) ***");
        $finish;
      end


endmodule
