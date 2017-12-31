`timescale 1ns/1ns
`define clk_period 20

module dis_top_tb;

reg clk;
reg rst_n;

wire DS;
wire ST_CP;
wire SH_CP;

dis_top dis_top(
                .clk(clk),
                .rst_n(rst_n),
                .DS(DS),
                .SH_CP(SH_CP),
                .ST_CP(ST_CP)
                 );
                 
initial clk=1'b1;
always  #(`clk_period/2) clk=~clk;

initial begin
	           rst_n = 1'b0;
	           #(`clk_period*20);
	           rst_n = 1'b1;
	           #(`clk_period*500);
	           $stop;	           
	      end  
endmodule	                    