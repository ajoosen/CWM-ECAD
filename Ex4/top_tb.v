//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #4 - Electronic Dice
// Student Name: Artjom Joosen
// Date: 09.06.2020
// 
// Description: A testbench module to test Ex4 - Electronic Dice
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
    parameter CLK_PERIOD = 10;

//Todo: Regitsers and wires
    reg rst;
    reg clk;
    reg button;
    reg err;
    wire [2:0] throw;
    reg [2:0] throw_prev;

//Todo: Clock generation
    initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=!clk;
    end

//Todo: User logic
	initial begin
       	err=0;
       	button=1;
	rst = 1;
    	clk = 0;
	#CLK_PERIOD rst = 0;

        forever begin

		#CLK_PERIOD if (rst&(throw!=0))
		begin
		   $display("***TEST FAILED! rst error");
		   err=1;
		end
			//state should not go back to throw=(000) or throw=(111) without rst=0
			if ((throw == 0) | (throw == 3'b111) &(rst!=0))
				begin
				   $display("***TEST FAILED! reset by accident");
				   err = 1;
				end

			else 
				begin
					if (throw_prev != 3'b110) 
					begin
						if ( ( button&(throw!=throw_prev+1) ) | ( !button&(throw!=throw_prev) ) )
						   begin
						     $display("***TEST FAILED! Button error");
						     err = 1;
						   end
						end
						else 
						begin
						if ( ( button&(throw!=3'b001) ) | ( !button&(throw!=throw_prev) ) )
							begin
							   $display("***TEST FAILED! Button error");
							err = 1;
							end
						end
				end

			//update throw and button
			throw_prev = throw;
			button = !button;

			end
	end

//Todo: Finish test, check for success
      initial begin
        #CLK_PERIOD 
        if (err==0)
          $display("***TEST PASSED! :) ***");
        $finish;
      end

//Todo: Instantiate counter module
	dice top (
	     .clk(clk),
	     .rst(rst),
	     .button(button),
	     .throw(throw)
	     );

endmodule 
