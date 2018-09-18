	component blinkled is
		port (
			clk_clk       : in  std_logic                    := 'X';             -- clk
			inputs_export : in  std_logic_vector(4 downto 0) := (others => 'X'); -- export
			leds_export   : out std_logic_vector(5 downto 0);                    -- export
			reset_reset_n : in  std_logic                    := 'X'              -- reset_n
		);
	end component blinkled;

	u0 : component blinkled
		port map (
			clk_clk       => CONNECTED_TO_clk_clk,       --    clk.clk
			inputs_export => CONNECTED_TO_inputs_export, -- inputs.export
			leds_export   => CONNECTED_TO_leds_export,   --   leds.export
			reset_reset_n => CONNECTED_TO_reset_reset_n  --  reset.reset_n
		);

