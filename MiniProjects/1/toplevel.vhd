library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity topLevel is
	port (
		fpga_clk_50  : in  std_logic;
		sw           : in  std_logic_vector(3 downto 0);
		key0         : in  std_logic;
		
      fpga_led_pio : out std_logic_vector(5 downto 0)
	);
end entity topLevel;

architecture rtl of topLevel is

	signal blink : std_logic := '0';
	signal divisor : integer;
	signal last_state : std_logic := '0';
	signal enable : std_logic := '0';

begin

	process(key0)
	begin
		if(falling_edge(key0)) then
			enable <= not enable;
		end if;
	end process;

	process(fpga_clk_50)
		
		variable counter : integer range 0 to 25000000 := 0;
		
	begin
		if(enable = '1') then
			if (rising_edge(fpga_clk_50)) then
				divisor <= to_integer(unsigned(sw));			
				if (counter < 10000000 / divisor) then
					counter := counter + 1;
				else
					blink <= not blink;
					counter := 0;
				end if;		
			end if;
		end if;
	end process;

  fpga_led_pio(0) <= blink;
  fpga_led_pio(1) <= blink;
  fpga_led_pio(2) <= blink;
  fpga_led_pio(3) <= blink;
  fpga_led_pio(4) <= blink;
  fpga_led_pio(5) <= blink;

end architecture;