module clock
(

	input clk_in,
	output clk_out

);

clock_mult clock_mult_inst 
(
	.inclk0 (clk_in),
	.c0 (clk_out)
);

endmodule
