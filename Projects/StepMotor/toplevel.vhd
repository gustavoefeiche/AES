library IEEE;
use IEEE.std_logic_1164.all;

entity topLevel is
    port (
        -- Gloabals
        fpga_clk_50        : in  std_logic;             -- clock.clk
		  
        -- I/Os
        fpga_led_pio       : out std_logic_vector(5 downto 0);
		  fpga_motor_pio     : out std_logic_vector(3 downto 0)
	);
end entity topLevel;

architecture rtl of topLevel is

   component stepmotor is
        port (
            clk_clk          		: in  std_logic                    := 'X'; -- clk
            leds_export      		: out std_logic_vector(5 downto 0);        -- export
            reset_reset_n    		: in  std_logic                    := 'X'; -- reset_n
	         stepmotor_1_export 	: out std_logic_vector(3 downto 0)         -- export
        );
    end component stepmotor;
	 
	 
begin

    u0 : component stepmotor
        port map (
            clk_clk          	 => fpga_clk_50,          --       clk.clk
            leds_export      	 => fpga_led_pio,      --      leds.export
            reset_reset_n    	 => '1',    --     reset.reset_n
            stepmotor_1_export => fpga_motor_pio  -- stepmotor.export
        );

end rtl;