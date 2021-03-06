----------------------------------------------------------------------------------
-- Company: USAFA
-- Engineer: C3C John Paul Terragnoli 
-- 
-- Create Date:    12:43:25 03/14/2014 
-- Module Name:    Prime_Floors_top_shell - Behavioral 
-- Target Devices: Nexys2 Project Board
-- Tool versions: 1.0
-- Description: This file is a shell for implementing designs on a NEXYS 2 board.  
--					It shall create the prime number elevator

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Prime_Floors_top_shell is
    Port ( 	clk_50m : in STD_LOGIC;
				btn : in  STD_LOGIC_VECTOR (3 DOWNTO 0);
				switch : in STD_LOGIC_VECTOR (7 DOWNTO 0);
				SSEG_AN : out STD_LOGIC_VECTOR (3 DOWNTO 0);
				SSEG : out STD_LOGIC_VECTOR (7 DOWNTO 0);
				LED : out STD_LOGIC_VECTOR (7 DOWNTO 0));
end Prime_Floors_top_shell;

architecture Behavioral of Prime_Floors_top_shell is

---------------------------------------------------------------------------------------
--This component converts a nibble to a value that can be viewed on a 7-segment display
--Similar in function to a 7448 BCD to 7-seg decoder
--Inputs: 4-bit vector cal "nibble"
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
	COMPONENT MooreElevatorControllerPrime_Shell
	PORT(
		clk : in  STD_LOGIC;
      reset : in  STD_LOGIC;
      stop : in  STD_LOGIC;
      up_down : in  STD_LOGIC;
      floor : out  STD_LOGIC_VECTOR (3 downto 0)
		);
	END COMPONENT; 
-----------------------------------------------------------------------------------
--No mealy machine required in this part
-----------------------------------------------------------------------------------


--------------------------------------------------------------------------------------
--Insert any required signal declarations below
--------------------------------------------------------------------------------------

signal currentFloorMoore : std_logic_vector (3 downto 0);

begin


------------------------------------------------------------
--code below tests the LEDs:
LED <= CLOCKBUS_SIG(26 DOWNTO 19);
------------------------------------------------------------

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
--prime_number_floors_machine Process(currentFloorMoore)
--begin
--	nibble0 <=  "0000";
--	nibble1 <= 	"0000";
--	--takes care of the first digit. 
--	if(currentFloorMoore<10) then
--		nibble2<= "0000";
--	else
--		nibble2<= "0001";
--	end if; 
--	
--	--takes care of the second digit.  
--	if(currentFloorMoore<10) then
--		nibble3<=currentFloorMoore;
--	else 
--		nibble3<= std_logic_vector(UNSIGNED(currentFloorMoore)-10);
--end process; 



	nibble0 <=  "0000";
	nibble1 <= 	"0000";	
	
	--this takes care of double digits and the numbers 17 and 19.  
	nibble2 <=  "0111" when (currentFloorMoore = "0000") else
					"1001" when (currentFloorMoore="1111") else
					currentFloorMoore when (UNSIGNED(currentFloorMoore)<10) else
					std_logic_vector(UNSIGNED(currentFloorMoore)-10);
					
	nibble3 <=  "0001" when 	(currentFloorMoore="1111") else
					"0001" when (currentFloorMoore = "0000")  else
					"0001" when (UNSIGNED(currentFloorMoore)>10) else
					"0000"; 

	
	
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
--Instantiate the design you with to implement below and start wiring it up!:
--right now this only works for 1 elevator with 4 floors.  
-----------------------------------------------------------------------------
	MooreElevatorLogicPrime : MooreElevatorControllerPrime_Shell
	PORT MAP(
		clk=>ClockBus_sig(25),
      reset=>btn(3),
      stop=>switch(7),
		--changed to 5 temporarily because switch 6 looks like it's broken.  
      up_down=>switch(5),
      floor=> currentFloorMoore
	);

-------------------------------------------------------------------------------
--Instantiate Mealy Machine
--No mealy machine required for the prime elevator. 
-------------------------------------------------------------------------------

end Behavioral;