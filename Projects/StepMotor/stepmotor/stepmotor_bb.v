
module stepmotor (
	clk_clk,
	leds_export,
	reset_reset_n,
	stepmotor_1_export);	

	input		clk_clk;
	output	[5:0]	leds_export;
	input		reset_reset_n;
	output	[3:0]	stepmotor_1_export;
endmodule
