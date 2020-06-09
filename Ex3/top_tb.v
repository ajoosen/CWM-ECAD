//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #3 - Up/Down counter
// Student Name: Artjom Joosen
// Date: 09.06.2020
//
// Description: A testbench module to test Ex3 - counter
// Guidance: start with simple tests of the module (how should it react to each 
// control signal?). Don't try to test everything at once - validate one part of 
// the functionality at a time.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
	parameter CLK_PERIOD = 10;

//Todo: Regitsers and wires
	reg clk;
	reg rst;
	reg direction;
	reg enable;
	reg err;
	wire [7:0] counter_out;
	reg [7:0] counter_out_prev;

//Todo: Clock generation
	initial begin
	clk = 1'b0;
	forever
		#(CLK_PERIOD/2) clk=~clk;
	end

//Todo: User logic
    	initial begin
	//initialise variables
	clk=0;
	rst=1;
	err=0;
	direction=1;
	enable=0;

	// accommodate clock transition
	#((CLK_PERIOD/2)+1)

	//accounting for different types of errors like in Ex2
	forever begin
		//err = 1 means error has occurred
		#(CLK_PERIOD-((CLK_PERIOD/2)+1)) 
		if (counter_out != counter_out_prev)
		begin
		  $display("***TEST FAILED! did not maintain 5 ticks gap!");
		  err = 1;
		end
		
		//enable error
		#((CLK_PERIOD/2)+1)
		if ((enable&&(counter_out==counter_out_prev))|(!enable&&(counter_out!=counter_out_prev))) 
		begin
		  $display("***TEST FAILED! enable");
		  err = 1;
		end

		//if direction ==1 and counter_out =/= counter_out_prev+1 or (equivalent statement for direction == -1), display 			error
		if ((direction&&(counter_out!=counter_out_prev+1))|(!direction&&(counter_out!=counter_out_prev-1))) 
		begin
		  $display("***TEST FAILED! wrong direction");
		  err = 1; 
		end

		//If rst is 1, then the counter should reset to 0.
		if (rst&&(counter_out!=0)) 
		begin
		  $display("***TEST FAILED! rst not does not reset properly");
		  err = 1;
		end

	//update counter
	counter_out_prev = counter_out;

	//switch counting direction
	if (counter_out==8'b00000011)
           direction=0;
	
	//account for going negative
	if ((direction==0) & (counter_out==8'b00000001))
		rst = 1;

	//when reset, the counter counts updwards
	if (rst==1)
		direction = 1;

	//avoid counter=0, rst=1 infinite loop
	if (counter_out==8'b00000000)
		rst = 0;
	
	//switch enable
	if (enable==0)
           enable = 1;	

	end

	end


//Todo: Finish test, check for success
      initial begin
	//give signals time to settle - 50 ticks
        #50 
        if (err==0)
          $display("***TEST PASSED! :) ***");
        $finish;
      end


//Todo: Instantiate counter module
	counter top(
	.rst (rst),
	.enable (enable),
	.direction (direction),
	.clk (clk),
	.counter_out (counter_out));
 
endmodule
