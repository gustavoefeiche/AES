-- Quartus Prime VHDL Template
-- Four-State Mealy State Machine

-- A Mealy machine has outputs that depend on both the state and
-- the inputs.	When the inputs change, the outputs are updated
-- immediately, without waiting for a clock edge.  The outputs
-- can be written more than once per state or per clock cycle.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity StepMotorPeripheral is
	port (
		clk    : in	 std_logic;
		reset	 : in	 std_logic;
		
		motor : out std_logic_vector(3 downto 0);
		
		-- Avalon Memmory Mapped Slave
	  avs_address     : in  std_logic_vector(3 downto 0)  := (others => '0'); 
	  avs_read        : in  std_logic                     := '0';             
	  avs_readdata    : out std_logic_vector(31 downto 0) := (others => '0'); 
	  avs_write       : in  std_logic                     := '0';           
	  avs_writedata   : in  std_logic_vector(31 downto 0) := (others => '0')  
	);

end entity;

architecture rtl of StepMotorPeripheral is

	type state_type is (s_stopped, s_step1, s_step2, s_step3, s_step4);

	signal state : state_type;
	signal enableAck : std_logic;
	signal state_controlled : std_logic := '0';
	signal enable : std_logic := '0';
	signal start : std_logic := '0';
	signal timer_trigger : std_logic;
	signal timerAck : std_logic;
	
	signal counterTimer : integer := 250000;
	signal direction : std_logic := '0';
	signal steps : integer := 0;
	signal cw : std_logic := '0';

begin

	avalon: process(clk)
	begin
		if (rising_edge(clk)) then
			steps <= 0;
			
			if(enableAck = '1') then
				enable <= '0';
			end if;
			
			if (avs_write = '1') then
				if(avs_address = "0000") then
					enable <= avs_writedata(0);
				elsif(avs_address = "0001") then
					counterTimer <= to_integer(unsigned(avs_writedata));
				elsif(avs_address = "0010") then
					cw <= avs_writedata(0);
				elsif(avs_address = "0011") then
					steps <= to_integer(unsigned(avs_writedata));
				end if;

			end if;
		end if;
	end process;

	process (clk, reset)
	
		variable step_count : integer := 0;
		
	begin
	
		if reset = '1' then
			state <= s_stopped;
			enableAck <= '0';

		elsif (rising_edge(clk)) then
			case state is
				
				when s_stopped=>
					enableAck <= '0';
					if enable = '1' then
						step_count := steps;
						if step_count = 0 then
							state <= s_stopped;
						else
							if cw = '1' then
								state <= s_step1;
							else
								state <= s_step4;
							end if;
							timer_trigger <= '1';
						end if;
					else
						state <= s_stopped;
					end if;
					
				when s_step1=>
					timer_trigger <= '0';
					if enable = '1' then
						if timerAck = '1' then
							step_count := step_count - 1;
							if step_count = 0 then
								state <= s_stopped;
								enableAck <= '1';
							else
								if cw = '1' then
									state <= s_step2;
								else
									state <= s_step4;
								end if;
								timer_trigger <= '1';
							end if;
						else
							state <= s_step1;
						end if;
					else
						state <= s_stopped;
					end if;
						
				when s_step2=>
					timer_trigger <= '0';
					if enable = '1' then
						if timerAck = '1' then
							step_count := step_count - 1;
							if step_count = 0 then
								state <= s_stopped;
								enableAck <= '1';
							else
								if cw = '1' then
									state <= s_step3;
								else
									state <= s_step1;
								end if;
								timer_trigger <= '1';
							end if;
						else
							state <= s_step2;
						end if;
					else
						state <= s_stopped;
					end if;	
					
				when s_step3=>
					timer_trigger <= '0';
					if enable = '1' then
						if timerAck = '1' then
							step_count := step_count - 1;
							if step_count = 0 then
								state <= s_stopped;
								enableAck <= '1';
							else
								if cw = '1' then
									state <= s_step4;
								else
									state <= s_step2;
								end if;
								timer_trigger <= '1';
							end if;
						else
							state <= s_step3;
						end if;
					else
						state <= s_stopped;
					end if;	
					
				when s_step4=>
					timer_trigger <= '0';
					if enable = '1' then
						if timerAck = '1' then
							step_count := step_count - 1;
							if step_count = 0 then
								state <= s_stopped;
								enableAck <= '1';
   						else
								if cw = '1' then
									state <= s_step1;
								else
									state <= s_step3;
								end if;
								timer_trigger <= '1';
							end if;
						else
							state <= s_step4;
						end if;
					else
						state <= s_stopped;
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
					motor <= "0000";
				when s_step1=>
					motor <= "0001";
				when s_step2=>
					motor <= "0010";
				when s_step3=>
					motor <= "0100";
				when s_step4=>
					motor <= "1000";
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
			if(timer_trigger = '1' or enable_fixo = '1') then
				if(counter < counterTimer) then
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
	
