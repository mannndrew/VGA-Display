`timescale 1 ns/1 ns
module test;
reg clk_in;
wire clk_out;

//First, instaniate your pulse generation module. Be sure to use module,  input clock and ouput pulse names you used in your design.

clock t1
(
	.clk_in(clk_in),
	.clk_out(clk_out)
);

//Second, create a clock 10ns low followed by 10ns high to to provide a 50Mhz (20ns) clock.
//Be sure that the clock sequence starts with clk low as shown below.
//The following sequence will loop and run indefinitely.

always
begin
clk_in <=0; #10;
clk_in <=1; #10;
end
endmodule
