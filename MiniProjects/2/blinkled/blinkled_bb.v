
module blinkled (
	clk_clk,
	inputs_export,
	leds_export,
	reset_reset_n);	

	input		clk_clk;
	input	[4:0]	inputs_export;
	output	[5:0]	leds_export;
	input		reset_reset_n;
endmodule
