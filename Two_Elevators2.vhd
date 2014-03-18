---------------------------------------------------------------------------------- 
-- Title       : Two_Elevators - Behavioral
-- Design      : Top shell for program creating two elevators.  
-- Author      : C3C John Paul Terragnoli
-- Company     : ECE281 Dream Team
-- File        : Two_Elevators.vhd
-- Generated   : Mon Mar 10 14:07:10 2014
-- From        : interface description file
-- Description : This file is a shell for implementing designs on a NEXYS 2 board
---------------------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity Two_Elevators is
    Port ( 	clk_50m : in STD_LOGIC;
				btn : in  STD_LOGIC_VECTOR (3 DOWNTO 0);
				switch : in STD_LOGIC_VECTOR (7 DOWNTO 0);
				--2 downto 0 is where the request came from.
				--5 downto 3 is where you want the elevator to go
				--after picking you up.  
				SSEG_AN : out STD_LOGIC_VECTOR (3 DOWNTO 0);
				SSEG : out STD_LOGIC_VECTOR (7 DOWNTO 0);
				LED : out STD_LOGIC_VECTOR (7 DOWNTO 0));
end Two_Elevators ;

architecture Behavioral of Two_Elevators is

---------------------------------------------------------------------------------------
--This component converts a nibble to a value that can be viewed on a 7-segment display
--Similar in function to a 7448 BCD to 7-seg decoder
--Inputs: 4-bit vector called "nibble"
--Outputs: 8-bit vector "sseg" used for driving a single 7-segment display
---------------------------------------------------------------------------------------
	COMPONENT nibble_to_sseg
	PORT(
		nibble : IN std_logic_vector(3 downto 0);          
		sseg : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

---------------------------------------------------------------------------------------------
--This component manages the logic for displaying values on the NEXYS 2 7-segment displays
--Inputs: system clock, synchronous reset, 4 8-bit vectors from 4 instances of nibble_to_sseg
--Outputs: 7-segment display select signal (4-bit) called "sel", 
--         8-bit signal called "sseg" containing 7-segment data routed off-chip
---------------------------------------------------------------------------------------------
	COMPONENT nexys2_sseg
	GENERIC ( CLOCK_IN_HZ : integer );
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		sseg0 : IN std_logic_vector(7 downto 0);
		sseg1 : IN std_logic_vector(7 downto 0);
		sseg2 : IN std_logic_vector(7 downto 0);
		sseg3 : IN std_logic_vector(7 downto 0);          
		sel : OUT std_logic_vector(3 downto 0);
		sseg : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

-------------------------------------------------------------------------------------
--This component divides the system clock into a bunch of slower clock speeds
--Input: system clock 
--Output: 27-bit clockbus. Reference module for the relative clock speeds of each bit
--			 assuming system clock is 50MHz
-------------------------------------------------------------------------------------
	COMPONENT Clock_Divider
	PORT(
		clk : IN std_logic;          
		clockbus : OUT std_logic_vector(26 downto 0)
		);
	END COMPONENT;
	
	



-------------------------------------------------------------------------------------
--Below are declarations for signals that wire-up this top-level module.
-------------------------------------------------------------------------------------

signal nibble0, nibble1, nibble2, nibble3 : std_logic_vector(3 downto 0);
signal sseg0_sig, sseg1_sig, sseg2_sig, sseg3_sig : std_logic_vector(7 downto 0);
signal ClockBus_sig : STD_LOGIC_VECTOR (26 downto 0);


--------------------------------------------------------------------------------------
--Insert your design's component declaration below	
--Component Declaration.  
--This component brings in the logic for the elevator using the moore machine. 
-------------------------------------------------------------------------------------
	COMPONENT Changed_Inputs_Moore
	PORT(
		clk : in  STD_LOGIC;
      reset : in  STD_LOGIC;
      desired_floor : in STD_LOGIC_VECTOR (2 downto 0);
      floor : out  STD_LOGIC_VECTOR (3 downto 0)
		);
	END COMPONENT; 


--------------------------------------------------------------------------------------
--Insert any required signal declarations below
--------------------------------------------------------------------------------------

signal currentFloorMoore1 : std_logic_vector (3 downto 0);
signal currentFloorMoore2 : std_logic_vector (3 downto 0);

--the difference signals are just holders for the difference between request floor and 
--the current floors of the elevators.  
signal difference1 : std_logic_vector (3 downto 0); 
signal difference2 : std_logic_vector (3 downto 0); 

--these are the floors that the elevators must go to!  
--these will change according to the input by the user.  
signal goToFloor1 : std_logic_vector (2 downto 0); 
signal goToFloor2 : std_logic_vector (2 downto 0); 


--
--signal output1 : std_logic_vector (2 downto 0); 
--signal output2 : std_logic_vector (2 downto 0);  

begin


----------------------------
--code below tests the LEDs:
----------------------------
LED <= CLOCKBUS_SIG(26 DOWNTO 19);

--------------------------------------------------------------------------------------------	
--This code instantiates the Clock Divider. Reference the Clock Divider Module for more info
--------------------------------------------------------------------------------------------

	Clock_Divider_Label: Clock_Divider PORT MAP(
		clk => clk_50m,
		clockbus => ClockBus_sig
	);

--------------------------------------------------------------------------------------	
--Code below drives the function of the 7-segment displays. 
--Function: To display a value on 7-segment display #0, set the signal "nibble0" to 
--				the value you wish to display
--				To display a value on 7-segment display #1, set the signal "nibble1" to 
--				the value you wish to display...and so on
--Note: You must set each "nibble" signal to a value. 
--		  Example: if you are not using 7-seg display #3 set nibble3 to "0000"
--------------------------------------------------------------------------------------

nibble0 <=  "0000";
nibble1 <= 	currentFloorMoore1;
nibble2 <= 	"0000";
nibble3 <=  currentFloorMoore2;

--This code converts a nibble to a value that can be displayed on 7-segment display #0
	sseg0: nibble_to_sseg PORT MAP(
		nibble => nibble0,
		sseg => sseg0_sig
	);

--This code converts a nibble to a value that can be displayed on 7-segment display #1
	sseg1: nibble_to_sseg PORT MAP(
		nibble => nibble1,
		sseg => sseg1_sig
	);

--This code converts a nibble to a value that can be displayed on 7-segment display #2
	sseg2: nibble_to_sseg PORT MAP(
		nibble => nibble2,
		sseg => sseg2_sig
	);

--This code converts a nibble to a value that can be displayed on 7-segment display #3
	sseg3: nibble_to_sseg PORT MAP(
		nibble => nibble3,
		sseg => sseg3_sig
	);
	
--This module is responsible for managing the 7-segment displays, you don't need to do anything here
	nexys2_sseg_label: nexys2_sseg 
	generic map ( CLOCK_IN_HZ => 50E6 )
	PORT MAP(
		clk => clk_50m,
		reset => '0',
		sseg0 => sseg0_sig,
		sseg1 => sseg1_sig,
		sseg2 => sseg2_sig,
		sseg3 => sseg3_sig,
		sel => SSEG_AN,
		sseg => SSEG
	);

-----------------------------------------------------------------------------
--Logic for which elevator picks the person up.  
-----------------------------------------------------------------------------

request_came_from_machine: process(ClockBus_sig(25),btn(3),switch(2 downto 0), currentFloorMoore1,
CurrentFloorMoore2)
begin
	if RISING_EDGE(ClockBus_sig(25))  then
	
	difference1 <= (std_logic_vector(unsigned(currentFloorMoore1)-unsigned(switch(2 downto 0))));
	difference2 <= (std_logic_vector(unsigned(currentFloorMoore2)-unsigned(switch(2 downto 0))));
	
		if(difference1 = "0000") then
			goToFloor1 <= currentFloorMoore1(2 downto 0); 
			goToFloor2 <= currentFloorMoore2(2 downto 0); 
		
		elsif(difference2 = "0000") then
			goToFloor1 <= currentFloorMoore1(2 downto 0); 
			goToFloor2 <= currentFloorMoore2(2 downto 0); 
		--if elevator 1 is closer, make the first elevator go to that place.  
		elsif((abs(signed(difference1))) < (abs(signed(difference2))))then
			goToFloor1 <= switch(2 downto 0); 
			goToFloor2 <= currentFloorMoore2(2 downto 0); 
		
		
		
	
			 
		elsif((abs(signed(difference1))) > (abs(signed(difference2))))then
			--if elevator 2 is closer, or they are both the same, make the second
			--elevator go to that place to pick the person up. 
			goToFloor1 <= currentFloorMoore1(2 downto 0);
			goToFloor2 <= switch(2 downto 0); 
		elsif((abs(signed(difference1)))=(abs(signed(difference2))))then
		--if elevator 2 is closer, or they are both the same, make the second
			--elevator go to that place to pick the person up. 
			goToFloor1 <= currentFloorMoore1(2 downto 0);
			goToFloor2 <= switch(2 downto 0); 
		else 
			goToFloor1 <= currentFloorMoore1(2 downto 0);
			goToFloor2 <= currentFloorMoore2(2 downto 0);
		end if; 
	else
	--what should be the else case?  
	end if; 
end Process;


-----------------------------------------------------------------------------
--Logic for where the picked up person will go.    
-----------------------------------------------------------------------------
--
--request_go_to_machine: process(ClockBus_sig(25),btn(3),switch(2 downto 0), currentFloorMoore1,
--CurrentFloorMoore2)
--begin
--	if RISING_EDGE(ClockBus_sig(25))  then
--		--if the first elevator is at the called floor
--		if(UNSIGNED(switch(2 downto 0))) = UNSIGNED(currentFloorMoore1) then
--			goToFloorIntermediate1 <=switch(5 downto 3); 
--			goToFloor1<=goToFloorIntermediate1;
----			goToFloor2 <= goToFloor2; 
--		
--		--if the second elevator is at the called floor.  
--		elsif(UNSIGNED(switch(2 downto 0))) = UNSIGNED(currentFloorMoore2) THEN 
--			goToFloorIntermediate2 <= switch(5 downto 3);
--			goToFloor2<=goToFloorIntermediate2;
--			
----			goToFloor1 <= goToFloor1; 
--		else 
----			goToFloor2 <= goToFloor2; 
----			goToFloor1 <= goToFloor1; 
--		end if; 	
--	else 
----		goToFloor2 <= currentMooreFloor2; 
----		goToFloor1 <= currentMooreFloor1;  
--	end if; 
--end Process;

-----------------------------------------------------------------------------
--Instantiate the design you with to implement below and start wiring it up!:
-----------------------------------------------------------------------------

SwitchesAsInputs1 : Changed_Inputs_Moore
			PORT MAP
			(
				clk=>ClockBus_sig(25),
				reset=>btn(3),
				desired_floor => goToFloor1,
				floor=> currentFloorMoore1
			);
 
SwitchesAsInputs2 : Changed_Inputs_Moore
			PORT MAP
			(
				clk=>ClockBus_sig(25),
				reset=>btn(3),
				desired_floor => goToFloor2,
				floor=> currentFloorMoore2
			);
			
end Behavioral;