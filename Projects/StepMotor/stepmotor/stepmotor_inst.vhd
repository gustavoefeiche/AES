	component stepmotor is
		port (
			clk_clk            : in  std_logic                    := 'X'; -- clk
			leds_export        : out std_logic_vector(5 downto 0);        -- export
			reset_reset_n      : in  std_logic                    := 'X'; -- reset_n
			stepmotor_1_export : out std_logic_vector(3 downto 0)         -- export
		);
	end component stepmotor;

	u0 : component stepmotor
		port map (
			clk_clk            => CONNECTED_TO_clk_clk,            --         clk.clk
			leds_export        => CONNECTED_TO_leds_export,        --        leds.export
			reset_reset_n      => CONNECTED_TO_reset_reset_n,      --       reset.reset_n
			stepmotor_1_export => CONNECTED_TO_stepmotor_1_export  -- stepmotor_1.export
		);

