-- Quartus Prime VHDL Template
-- Four-State Mealy State Machine

-- A Mealy machine has outputs that depend on both the state and
-- the inputs.	When the inputs change, the outputs are updated
-- immediately, without waiting for a clock edge.  The outputs
-- can be written more than once per state or per clock cycle.

library ieee;
use ieee.std_logic_1164.all;

entity StepMotor is

	port (
		clk    : in	 std_logic;
		input	 : in	 std_logic;
		reset	 : in	 std_logic;
		fasesMotor : out std_logic_vector(3 downto 0)
	);

end entity;

architecture rtl of StepMotor is

	-- Build an enumerated type for the state machine
	type state_type is (s_stopped, s_step1, s_step2, s_step3, s_step4);

	-- Register to hold the current state
	signal state : state_type;
	signal enable : std_logic := '0';

begin

	process (clk, reset)
	begin

		if reset = '1' then
			state <= s0;

		elsif (rising_edge(clk)) then
			case state is
				when s_stopped=>
					if enable = '1' then
						state <= s_step1;
						timerEn <= '1';
					else
						state <= s0;
					end if;
				when s_step1=>
					timerEn <= '0';
					if input = '1' then
						state <= s2;
					else
						state <= s1;
					end if;
				when s2=>
					if input = '1' then
						state <= s3;
					else
						state <= s2;
					end if;
				when s3=>
					if input = '1' then
						state <= s3;
					else
						state <= s1;
					end if;

			end case;
							
			if (enable = '0') then
				state <= s_stopped;
			end if;
	
		end if;
	end process;

	process (state)
	begin
			case state is
				when s_stopped=>
					fasesMotor  <= "0000";
				when s_step1=>
					faesesMotor <= "0001";
				when s_step2=>
					faesesMotor <= "0010";
				when s_step3=>
					faesesMotor <= "0100";
				when s_step4=>
					faesesMotor <= "1000";
			end case;
	end process;

	process(clk)
		variable counter : integer := 0;
		variable enable_fixo : std_logic;
	begin
		if (reset = '1') then
			counter  := 0;
			timerAck <= '0';
			enable_fixo := '0';
		elsif (rising_edge(clk)) then
			if(timerEn_pulso = '1' || enable_fixo = '1') then
				if(couter < XXXXXXXXX) then
					timerAck <= '0';
					counter  := counter +1;
					enable_fixo  := '1';
				else
					counter  := 0;
					timerAck <= '1';
					enable_fixo  := '0';
				end if;
			else
				counter := 0;
				timerAck <= '0';
			end if;
		end if;
	end process;
	
end rtl;



