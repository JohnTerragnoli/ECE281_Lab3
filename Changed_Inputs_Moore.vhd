----------------------------------------------------------------------------------
-- Company: USAFA/DFEC
-- Engineer: John Paul Terragnoli
-- 
-- Create Date:    	20:33:47 06/03/2014 
-- Design Name:		Lab3
-- Module Name:    	Changed_Inputs_Moore - Behavioral 
-- Description: 		Allows the user to choose the floor to go to with the switches.   
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity Changed_Inputs_Moore is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           desired_floor : in std_logic_vector(2 downto 0);
           floor : out  STD_LOGIC_VECTOR (3 downto 0));
end Changed_Inputs_Moore;

architecture Behavioral of Changed_Inputs_Moore is

--Below you create a new variable type! You also define what values that 
--variable type can take on. Now you can assign a signal as 
--"floor_state_type" the same way you'd assign a signal as std_logic 
type floor_state_type is (floor0,floor1, floor2, floor3, floor4,floor5,floor6,floor7);

--Here you create a variable "floor_state" that can take on the values
--defined above. Neat-o!
signal floor_state : floor_state_type;

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
			floor_state <= floor1;
		--now we will code our next-state logic
		else
			case floor_state is
				--when our current state is floor0	
				when floor0 =>
					--still too low
					if (UNSIGNED(desired_floor) > 0) then 
						floor_state <= floor1;
					--on the money
					elsif(desired_floor = "000") then
						floor_state <=floor0;
					--still too high
					elsif (UNSIGNED(desired_floor) < 0)then
						floor_state <= floor0;
					--other
					else 
						floor_state <= floor0; 
					end if;
					
				--when our current state is floor1
				when floor1 =>
					--still too low
					if ((UNSIGNED(desired_floor)) > 1) then 
						--floor2 right?? This makes sense!
						floor_state <= floor2;
					--on the money
					elsif(desired_floor = "001") then
						floor_state <=floor1;
					--still too high
					elsif (UNSIGNED(desired_floor) < 1)then
						floor_state <= floor0;
					--other
					else 
						floor_state <= floor1; 
					end if;
					
				--when our current state is floor2
				when floor2 => 
					if (UNSIGNED(desired_floor) > 2) then 
						floor_state <= floor3;
					elsif(desired_floor = "010") then
						floor_state <=floor2;
					--otherwise we're going to stay at floor1
					elsif (UNSIGNED(desired_floor) < 2)then
						floor_state <= floor1;
					else 
						floor_state <= floor2; 
					end if;


				when floor3 =>
					if (UNSIGNED(desired_floor) > 3) then 
						floor_state <= floor4;
					elsif(desired_floor = "011") then
						floor_state <=floor3;
					--otherwise we're going to stay at floor1
					elsif (UNSIGNED(desired_floor) < 3)then
						floor_state <= floor2;
					else 
						floor_state <= floor3; 
					end if;
				when floor4 =>
					if (UNSIGNED(desired_floor) > 4) then 
						floor_state <= floor5;
					elsif(desired_floor = "100") then
						floor_state <=floor4;
					--otherwise we're going to stay at floor1
					elsif (UNSIGNED(desired_floor) < 4)then
						floor_state <= floor3;
					else 
						floor_state <= floor4; 
					end if;
				--when on the fifth floor: 
				when floor5 =>
					if (UNSIGNED(desired_floor) > 5) then 
						floor_state <= floor6;
					elsif(desired_floor = "101") then
						floor_state <=floor5;
					--otherwise we're going to stay at floor1
					elsif (UNSIGNED(desired_floor) < 5)then
						floor_state <= floor4;
					else 
						floor_state <= floor5; 
					end if;
				--when on the sixth floor: 
				when floor6 =>
					if (UNSIGNED(desired_floor) > 6) then 
						floor_state <= floor7;
					elsif(desired_floor = "110") then
						floor_state <=floor6;
					--otherwise we're going to stay at floor1
					elsif (UNSIGNED(desired_floor) < 6)then
						floor_state <= floor5;
					else 
						floor_state <= floor6; 
					end if;
					--when on the seventh floor: 
				when floor7 =>
					if (UNSIGNED(desired_floor) > 7) then 
						floor_state <= floor7;
					elsif(desired_floor = "111") then
						floor_state <=floor7;
					--otherwise we're going to stay at floor1
					elsif (UNSIGNED(desired_floor) < 7)then
						floor_state <= floor6;
					else 
						floor_state <= floor7; 
					end if;
				when others =>
					floor_state <= floor1;
			end case;
		end if;
	else
		floor_state <= floor_state;
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

end Behavioral;