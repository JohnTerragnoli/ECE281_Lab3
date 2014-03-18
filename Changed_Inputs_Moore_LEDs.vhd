----------------------------------------------------------------------------------
-- Company: USAFA/DFEC
-- Engineer: John Paul Terragnoli
-- 
-- Create Date:    	20:33:47 06/03/2014 
-- Design Name:		Lab3
-- Module Name:    	Changed_Inputs_Moore_LEDs - Behavioral 
-- Description: 		Allows the user to choose the floor to go to with the switches.  
-- 						And the lights should right when the elevator is moving up and 
--							left when the elevator is moving down.  
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity Changed_Inputs_Moore_LEDs is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           desired_floor : in std_logic_vector(2 downto 0);
			  moving_updown : out STD_LOGIC_VECTOR (1 downto 0);
			  floor_light : out std_logic_vector (7 downto 0);
           floor : out  STD_LOGIC_VECTOR (3 downto 0));
end Changed_Inputs_Moore_LEDs;

architecture Behavioral of Changed_Inputs_Moore_LEDs is

--Below you create a new variable type! You also define what values that 
--variable type can take on. Now you can assign a signal as 
--"floor_state_type" the same way you'd assign a signal as std_logic 
type floor_state_type is (floor0,floor1, floor2, floor3, floor4,floor5,floor6,floor7);

--Here you create a variable "floor_state" that can take on the values
--defined above. Neat-o!
signal floor_state : floor_state_type;

type up_down_type is (up,down,still);

SIGNAL up_down: up_down_type;

begin
---------------------------------------------
--Below you will code your next-state process
---------------------------------------------

--This line will set up a process that is sensitive to the clock
floor_state_machine: process(clk,desired_floor,floor_state)
begin
	--clk'event and clk='1' is VHDL-speak for a rising edge
	--but Capt. Sivla said that winners write it this way.  
	if RISING_EDGE(CLK)  then
		--reset is active high and will return the elevator to floor1
		--Question: is reset synchronous or asynchronous?
		--synchronous.  
		if reset='1' then
			floor_state <= floor0;
			up_down <= still; 
		--now we will code our next-state logic
		else
			case floor_state is
				--when our current state is floor0	
				when floor0 =>
					--still too low
					if (UNSIGNED(desired_floor) > 0) then 
						floor_state <= floor1;
						up_down <= up; 
					--on the money
					elsif(desired_floor = "000") then
						floor_state <=floor0;
						up_down <= still; 
					--still too high
					elsif (UNSIGNED(desired_floor) < 0)then
						floor_state <= floor0;
						up_down <= still; 
					--other
					else 
						floor_state <= floor0; 
						up_down <= still; 
					end if;
					
				--when our current state is floor1
				when floor1 =>
					--still too low
					if ((UNSIGNED(desired_floor)) > 1) then 
						--floor2 right?? This makes sense!
						floor_state <= floor2;
						up_down <= up; 
					--on the money
					elsif(desired_floor = "001") then
						floor_state <=floor1;
						up_down <= still; 
					--still too high
					elsif (UNSIGNED(desired_floor) < 1)then
						floor_state <= floor0;
						up_down <= down; 
					--other
					else 
						floor_state <= floor1; 
						up_down <= still; 
					end if;
					
				--when our current state is floor2
				when floor2 => 
					if (UNSIGNED(desired_floor) > 2) then 
						floor_state <= floor3;
						up_down <= up; 
					elsif(desired_floor = "010") then
						floor_state <=floor2;
						up_down <= still; 
					--otherwise we're going to stay at floor1
					elsif (UNSIGNED(desired_floor) < 2)then
						floor_state <= floor1;
						up_down <= down; 
					else 
						floor_state <= floor2;
						up_down <= still; 						
					end if;


				when floor3 =>
					if (UNSIGNED(desired_floor) > 3) then 
						floor_state <= floor4;
						up_down <= up; 
					elsif(desired_floor = "011") then
						floor_state <=floor3;
						up_down <= still; 
					--otherwise we're going to stay at floor1
					elsif (UNSIGNED(desired_floor) < 3)then
						floor_state <= floor2;
						up_down <= down; 
					else 
						floor_state <= floor3; 
						up_down <= still; 
					end if;
				when floor4 =>
					if (UNSIGNED(desired_floor) > 4) then 
						floor_state <= floor5;
						up_down <= up; 
					elsif(desired_floor = "100") then
						floor_state <=floor4;
						up_down <= still; 
					--otherwise we're going to stay at floor1
					elsif (UNSIGNED(desired_floor) < 4)then
						floor_state <= floor3;
						up_down <= down; 
					else 
						floor_state <= floor4; 
						up_down <= still; 
					end if;
				--when on the fifth floor: 
				when floor5 =>
					if (UNSIGNED(desired_floor) > 5) then 
						floor_state <= floor6;
						up_down <= up; 
					elsif(desired_floor = "101") then
						floor_state <=floor5;
						up_down <= still; 
					--otherwise we're going to stay at floor1
					elsif (UNSIGNED(desired_floor) < 5)then
						floor_state <= floor4;
						up_down <= down; 
					else 
						floor_state <= floor5; 
						up_down <= still; 
					end if;
				--when on the sixth floor: 
				when floor6 =>
					if (UNSIGNED(desired_floor) > 6) then 
						floor_state <= floor7;
						up_down <= up; 
					elsif(desired_floor = "110") then
						floor_state <=floor6;
						up_down <= still; 
					--otherwise we're going to stay at floor1
					elsif (UNSIGNED(desired_floor) < 6)then
						floor_state <= floor5;
						up_down <= down; 
					else 
						floor_state <= floor6; 
						up_down <= still; 
					end if;
					--when on the seventh floor: 
				when floor7 =>
					if (UNSIGNED(desired_floor) > 7) then 
						floor_state <= floor7;
						up_down <= still; 
					elsif(desired_floor = "111") then
						floor_state <=floor7;
						up_down <= still; 
					--otherwise we're going to stay at floor1
					elsif (UNSIGNED(desired_floor) < 7)then
						floor_state <= floor6;
						up_down <= down; 
					else 
						floor_state <= floor7; 
						up_down <= still; 
					end if;
				when others =>
					floor_state <= floor1;
					up_down <= still; 
			end case;
		end if;
	else
		floor_state <= floor_state;
		up_down <= up_down; 
	end if;
end process;

-- Here you define your output logic. Finish the statements below
floor <= "0000" when (floor_state =  floor0) else 
			"0001" when (floor_state =  floor1) else
			"0010" when (floor_state =  floor2) else
			"0011" when (floor_state =  floor3) else
			"0100" when (floor_state =  floor4) else
			"0101" when (floor_state =  floor5) else
			"0110" when (floor_state =  floor6) else
			"0111" when (floor_state =  floor7) else
			--this last line should account for phantom states.  
			"0001";
			
-- Here you define your output logic. Finish the statements below
floor_light <= "00000001" when (floor_state =  floor0) else 
			"00000010" when (floor_state =  floor1) else
			"00000100" when (floor_state =  floor2) else
			"00001000" when (floor_state =  floor3) else
			"00010000" when (floor_state =  floor4) else
			"00100000" when (floor_state =  floor5) else
			"01000000" when (floor_state =  floor6) else
			"10000000" when (floor_state =  floor7) else
			--this last line should account for phantom states.  
			"00000000";
			
			
--helps set up the direciton of the lights.  
moving_updown <= "01" when (up_down = up) else
					  "00" when (up_down = down) else
					  "10" when (up_down = still) else
					  "11";

end Behavioral;