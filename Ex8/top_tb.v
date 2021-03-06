//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #8 - Times Table using AXI interface
// Student Name: Artjom Joosen
// Date: 12.06.2020
//
// Description: A testbench module to test Ex8 - Times Table using AXI4-Lite
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
);

//Todo: Parameters
    parameter CLK_PERIOD = 10;
    
//Todo: Registers and wires
    reg rst;
    reg enable;
    reg clk;
    reg err;
    reg [2:0]a;
    reg [2:0]b;

    wire [5:0]result;

//Todo: Clock generation
    initial begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=!clk;
    end 
    
    
//Todo: User logic
    initial begin
        err=0;
        enable=1;
        rst=0;
        a=0;
        b=0;

        #CLK_PERIOD rst=1;
        
	#CLK_PERIOD if(result!=0)
            begin
                $display("***TEST FAILED!***");
                err=1;
            end
        a=6;
        b=0;

        forever begin
            #(CLK_PERIOD*10) if(result!=(a*b))
                begin
                    $display("***TEST FAILED!***");
                    err=1;
                end
            b=b+1;
        end
    end


//Todo: Finish test, check for success
    initial 
    begin
       #600
       if (err==0)
         $display("***TEST PASSED! :)***");
       $finish;
    end


//Todo: Instantiate counter module
	multiplier top(.clk(clk), .rst(rst), .enable(enable), .a(a), .b(b), .result(result) );


endmodule   
