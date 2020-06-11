//////////////////////////////////////////////////////////////////////////////////
// Exercise #8
// Student Name:ement a times table of 0..7x0..7
//  using a memory and AXI-4-lite interface.
// Date: 
//
//  Description: In this exercise, you need to impl
//
//  inputs:
//           clk, rst, a[2:0], b[2:0], read
//
//  outputs:
//           result[5:0]
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 100ps

module times_table (
	input clk,
	input [2:0] a,
	input [2:0] b,
	input enable,
	input rst,
	output wire [5:0] result
	);

	wire [32:0] addr;
	wire awready;
	wire rsta_busy;
	wire rstb_busy;
	wire wready;
	wire [1:0] bresp;
	wire bvalid;
	wire arready;
	wire rvalid;
	wire s_axi_rresp;
	
	
	assign addr = {24'd0,a,b,2'd0};

	blk_mem_gen_0 Axi4_multiply (
	  .rsta_busy(rsta_busy),          
	  .rstb_busy(rstb_busy),          
	  .s_aclk(clk),                
	  .s_aresetn(rst),      
	    
	  .s_axi_awaddr(0),    
	  .s_axi_awvalid(0),  
	  .s_axi_awready(awready),  
	  .s_axi_wdata(0),      
	  .s_axi_wstrb(0),      
	  .s_axi_wvalid(0),    
	  .s_axi_wready(wready),   
	  .s_axi_bresp(bresp),      
	  .s_axi_bvalid(bvalid),    
	  .s_axi_bready(0),    
	  .s_axi_araddr(addr),    
	  .s_axi_arvalid(1),  
	  .s_axi_arready(arready),  
	  .s_axi_rdata(result),      
	  .s_axi_rresp(s_axi_rresp),     
	  .s_axi_rvalid(rvalid),    
	  .s_axi_rready(enable)    
	);

endmodule
