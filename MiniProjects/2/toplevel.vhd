library IEEE;
use IEEE.std_logic_1164.all;

entity topLevel is
	port (
		fpga_clk_50  : in  std_logic;
		fpga_but_pio : in  std_logic_vector(4 downto 0);
      fpga_led_pio : out std_logic_vector(5 downto 0)
	);
end entity topLevel;

architecture rtl of topLevel is

	component blinkled is
		port (
			clk_clk       : in  std_logic                    := 'X'; -- clk
			reset_reset_n : in  std_logic                    := 'X'; -- reset_n
			inputs_export : in  std_logic_vector(4 downto 0) := (others => 'X'); -- export
			leds_export   : out std_logic_vector(5 downto 0)         -- export
		);
	end component blinkled;

begin

	u0 : component blinkled
		port map (
			clk_clk       => fpga_clk_50,       --   clk.clk
			reset_reset_n => '1', -- reset.reset_n
			inputs_export => fpga_but_pio, -- inputs.export
			leds_export   => fpga_led_pio    --  leds.export
		);

end architecture;