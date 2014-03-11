library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity nexys2_sseg is
	generic ( CLOCK_IN_HZ : integer );
	port ( clk   : in std_logic; -- 50 MHz clock
	       reset : in std_logic;
		   sseg0 : in std_logic_vector(7 downto 0);
	       sseg1 : in std_logic_vector(7 downto 0);
		   sseg2 : in std_logic_vector(7 downto 0);
		   sseg3 : in std_logic_vector(7 downto 0);
		   sel   : out std_logic_vector(3 downto 0); -- Select sseg channel (active low)
		   sseg  : out std_logic_vector(7 downto 0)); -- Output data
end nexys2_sseg;

architecture behavioral of nexys2_sseg is
	constant TICKS_IN_MS : integer := CLOCK_IN_HZ / 1E3;
	
	type state_type is (s0, s1, s2, s3);
	signal state_reg, state_next : state_type;
	signal count_reg, count_next : unsigned(20 downto 0) := (others => 'U');
	signal sseg_reg, sseg_next : std_logic_vector(7 downto 0) := (others => 'U');
	signal sel_reg, sel_next : std_logic_vector(3 downto 0) := (others => 'U');
begin

	sseg <= sseg_reg;
	sel <= sel_reg;

	process (clk) is
	begin
		if rising_edge(clk) then
			if reset = '1' then
				count_reg <= (others => '0');
				state_reg <= s0;
				sseg_reg <= (others => '0');
				sel_reg <= (others => '0');
			else
				count_reg <= count_next;
				state_reg <= state_next;
				sseg_reg <= sseg_next;
				sel_reg <= sel_next;
			end if;
		end if;
	end process;

	count_next <= (others => '0') when count_reg = TICKS_IN_MS else
	              count_reg + 1;

	process (state_reg, count_reg) is
	begin
		state_next <= state_reg;
		
		if count_reg = TICKS_IN_MS then
			case (state_reg) is
				when s0 =>
					state_next <= s1;
				when s1 =>
					state_next <= s2;
				when s2 =>
					state_next <= s3;
				when s3 =>
					state_next <= s0;
			end case;
		end if;
	end process;
	
	process (state_next, sseg_reg, sel_reg, sseg0, sseg1, sseg2, sseg3) is
	begin
		sseg_next <= sseg_reg;
		sel_next <= sel_reg;
		
		case (state_next) is
				when s0 =>
					sseg_next <= sseg0;
					sel_next <= "1110";
				when s1 =>
					sseg_next <= sseg1;
					sel_next <= "1101";
				when s2 =>
					sseg_next <= sseg2;
					sel_next <= "1011";
				when s3 =>
					sseg_next <= sseg3;
					sel_next <= "0111";
			end case;
	end process;
end behavioral;
