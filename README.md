ECE281_Lab3
===========
#**Prelab**
The purpose of the prelab was to acquire a basic understanding for the archtecture of the program describing the behavior of an elevator.  

The following files were provided initially.  

[Clock_Divider] (https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Clock_Divider.vhd)  This controls clock functions for the behavior of the elevator design.  This is contained in the Nexys2_top_shell_original.vhd module.  

[Nexys2_top_shell_original] (https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Nexys2_top_shell_original.vhd)   This module combines the functioning of the clock, the converting of nibbles to data that can be output to the seven segment display on the Nexys2, and transfers data to show onto a seven segment display.  This is not finished and surely will have more functionality towards the end of the lab.  The schematic of this shell is shown lower in this README.

[nexys2_sseg_original](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/nexys2_sseg_original.vhd)  This takes data and displays it onto the seven segment display on the Nexys2.   This is contained in the Nexys2_top_shell_original.vhd module.  

[nibble_to_sseg_original] (https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/nibble_to_sseg_original.vhd)  This intakes data in the form of nibbles and converts the data to a form that can be output to a seven segment display on the Nexys2.  This is contained in the Nexys2_top_shell_original.vhd module.  

[pinout_original] (https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/pinout_original.ucf) This module designates the inputs and the outputs of this program to specific locations on the Nexys2 board.  

Nothing was edited in the clock divider shell or the nexys2 top shell.   

#Prelab Schematic
Below shows the current structure of the module Nexys2_top_shell.vhd that was given in the assignment.  

 ![alt tag](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Prelab%20Schematic1.jpg "Prelab Schematic of Nexys2_top_shell.vhd")

Note: Because the design is not finished, there are many hanging inputs, meaning that the inputs have not be specified.  These inputs include, but are not limited to, btn(3:0) and switch (7:0).  Also, the internal signals nibble0(3:0), nibble1(3:0), nibble2(3:0), and nibble3(3:0) are necessary for the design but appear to come from nowhere in the schematic.  This is because their origin has not been specified yet. 

The only components shown in this diagram are the ones that were in the original Nexys2_top_shell.vhd file here: [Nexys2_top_shell_original] (https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Nexys2_top_shell_original.vhd) This is the same file shown in the beginning.  Again, it is unaltered from the original.  

#Documentation: Prelab
NONE

#**Functionality**
The following levels of functionality were achieved in this lab.  

#Basic Functionality Moore

#Basic Functionality Mealy

#First 8 Prime Numbers

#Changed Inputs

#Moving LEDs

#Multiple Elevators

ALL LEVELS OF FUNCTIONALITY WERE ACHIEVED

Details on each functionality level can be seen below!



#**8 Floor Elevator using Moore Machine**
Using the files from computer excercise three, the actual logic for defining the behavior of an elevator was imported.  Using this logic, an immitation of an elevator was created on the Nexys2 board.  This logic was initially created using a Moore machine.  The file for this logic can be seen here: [Moore Behavioral File](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/MooreElevatorControllerCE3.vhd) This file was altered, however, from the original CE3 file logic.  It was modified to be able to handle floors 1-8 instead of just floors 1-4.  Aside from this, no changes were made.  The original file can be seen here: [Original Moore Logic](https://raw.github.com/JohnTerragnoli/ECE281_CE3/master/MooreElevatorController_Shell.vhd)

Once the Moore logic was perfected, it was used as a component in the main file Nexys2_top_sell.vhd shown here: [top_shell](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Nexys2_top_shell.vhd). 

The inputs to the top shell were then assigned to be used as inputs in the Moore Machine component.  Also, the outputs of the Moore Machine component were returned to the top shell and assigned as a nibble.  This allowed the output of the Moore Machine component to appear on the 7 segment display and for the elevator to respond to the up/down and stop switches, and the reset button.  

Switches were assigned as inputs to the stop and up/down functions in the shell on the Nexys2 board, as well as a resent button for the elevator.  This was done using the .ucf file here:  [Inputs and Outputs specifications](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/pinout.ucf)

Once all of this was done, a .bit file was created and uploaded to the Nexys2 board.  This .bit file can be seen in the files of this repository labeled as MooreElevatorController_Shell.bit.  Unforunately, a direct link to the raw data cannot be made here.  

#**4 Floor Mealy Machine**
The mealy machine module created in Computer Exercise 3 was then used to code the logic for the elevator on the Nexys2 board.  The outputs onto the Nexys2 board were the nextFloor output and the currentFloor output of the Mealy Machine.  The Mealy Machine has the same inputs as the Moore Machine, a stop switch, an up/down switch, and a reset button.  

The top shell was updated to include a declaration and an instantiation of the Mealy Machine.  This file is reproduced here: [top_shell](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Nexys2_top_shell.vhd).  

The Moore Machine functionality was kept on the Moore Machine. The bit file that was sent to the Nexys2 board can be seen labeled as MealyElevatorController_Shell.bit in the repository.  This file contains the code to make the Moore and Mealy Machine work on the Nexys2 board.  

Note: Only four floors were used in the Mealy Machine because there are so many combinations of inputs with the current floor.  This phenomenon gets worse as the number of floors increases.  

The file for the Mealy Machine logic is produced here:  [Mealy Machine Code](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/MealyElevatorController_Shell.vhd)  


#**8 Prime Number Floors**

In this part of the lab, 8 floors were still used on the elevator, and the up/down, reset, and stop inputs were still controlling how the elevator moved.  However, the floors were not numbered 1-8, but instead were numbered, 2,3,5,7,11,13,17,19, for the first 8 prime numbers.  

The files for this program can be seen below: 

[Clock_Divider](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Clock_Divider.vhd)  This controls clock functions for the behavior of all elevator designs. This is contained in the Prime_Numbers_top_shell.vhd module. This was not altered.  

[MooreElevatorControllerPrime_Shell](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/MooreElevatorControllerPrime_Shell.vhd)  This file was altered from previous designs to account for the numbers that would be displayed onto the seven segment display.  Many of the outputs that related to floors 1-8 were just changed to the desired floors.  However, the output contains only 4 bits.  Therefore, to get the numbers 17 and 19, "code" numbers were created, meaning that 17 and 19 were each represented as 2 separate 4 bit numbers.  These two numbers were then recognized in the Prime_floors_top_shell.vhd file as being 17 and 10 so the appropriate values were output to the Nexys2 board.  

[Prime_Floors_top_shell](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Prime_Floors_top_shell.vhd) This was slightly altered to account for double digit numbers and the numbers 17 and 19.  Logic was used to make sure that if the number trying to be output was greater than 10, then the first seven segment display would show a 1, if not, it would show a 0.  Then, the second digit of the output would be displayed on the second seven segment display.  

[Nexys2_sseg](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/nexys2_sseg.vhd)This takes data and displays it onto the seven segment display on the Nexys2. This is contained in the Prime_Numbers_top_shell.vhd module.  This was not altered.  

[Nibble_to_sseg](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/nibble_to_sseg.vhd) This intakes data in the form of nibbles and converts the data to a form that can be output to a seven segment display on the Nexys2. This is contained in the Prime_Numbers_top_shell.vhd module. This was not altered.  

[Pintout.ucf](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/pinout_original.ucf) This module designates the inputs and the outputs of this program to specific locations on the Nexys2 board. This was not altered.  

The file prime_floors_top_shell.bit can be seen in the repository under the commit prime number elevator1.

As a result of these alterations, the prime floors elevator was able to work perfectly.  


#**8 Floors Specific Floor Input**
This demonstration is the same as the basic functionality, however, the inputs consist of 3 switches that determine the desired floor of the user. The user will use the switches to tell the elevator which floor to go to. Also, the reset button was kept, just for kicks. 

The files used for this program can be seen below: 

[Changed_Inputs_Elevator](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Changed_Inputs_Elevator.vhd)  This was the top shell for the elevator. A copy from the original basic functionality was used intially and altered. In this shell, the declaration and the instantiation was altered to be one of the Changed_Inputs_Moore module. Aside from that, not muct was changed, except that floors were made to be 0-7. 

[Changed_Inputs_Moore](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Changed_Inputs_Moore.vhd)   This module contained the Moore Machine logic for the elevator. It was similar to the Moore logic used in previous designs, however, this Moore Machine took in a std_logic_vector of length 3 as the desired floor of the user. The module then checks whether or not the current floor is above, at, or below the desired floor, and moves in the proper direction or stays put as necessary. Also, the floors were made to be 0-7. 

[Nexys2_sseg](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/nexys2_sseg.vhd) This file was the same as in previous designs. 

[Nibble_to_sseg](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/nibble_to_sseg.vhd) This file was the same as in previous designs. 

[Clock_Divider](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Clock_Divider.vhd)  This file was the same as in previous designs. 

[Pinout](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/pinout.ucf) This file was the same as in previous designs.

The bit file used to program the Nexys2 board can be seen in this repository labeled changed_inputs_elevator.bit under the commit "specific inputs2". 

#**8 Floors Moving LEDs** 

The point of this program was to have the LEDs on the Nexys2 appear to be moving to the left when the floors were going up, and have the LEDs appear to be moving to the right when going down. The files used are shown below:

[Moving_LEDs](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Moving_LEDs.vhd) This was the top shell for the elevator. A copy from the original basic functionality was used intially and altered. In this shell, the declaration and the instantiation was altered to be one of the Changed_Inputs_Moore_LEDs module. This shell was simply changed such that a std_logic_vector output by the Moore Machine logic would determine which LED would light up and when. 

[Changed_Inputs_Moore_LEDs](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Changed_Inputs_Moore_LEDs.vhd) This module contained the Moore Machine logic for the elevator. It was similar to the Moore logic used in previous designs, however, this Moore Machine also returned a std_logic_vector according to what floor the elevator was on. 

[Nexys2_sseg](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/nexys2_sseg.vhd) This file was the same as in previous designs. 

[Nibble_to_sseg](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/nibble_to_sseg.vhd) This file was the same as in previous designs. 

[Clock_Divider](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Clock_Divider.vhd) This file was the same as in previous designs. 

[Pinout](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/pinout.ucf) This file was the same as in previous designs.

The bit file used to program the Nexys2 board can be seen in this repository labeled moving_leds.bit under the commit "LEDs1". 

#**2 Elevators** 

This design creates two elevators.  Then, the user may call for an elevator from a specific floor.  The closest elevator picks up the user, or if both are the same distance from the called elevator, only one elevator will go pick up the user. A video of this working can be seen here: [Two_Elevators_Simulation](https://www.youtube.com/watch?v=_m5-nXUHLnw&feature=youtu.be)

The files used to do this can be seen here: 

[2_Elevators](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Two_Elevators2.vhd)  This was the top shell for the elevator. Logic was added so that the closest elevator would be sent to the requested floor. This was accomplished using a process.  

[Changed_Inputs_Moore](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Changed_Inputs_Moore.vhd) his module contained the Moore Machine logic for the elevator. This is the same file used in the 8 floor alternate method of specifying inputs. 

[Nexys2_sseg](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/nexys2_sseg.vhd) This file was the same as in previous designs. 

[Nibble_to_sseg](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/nibble_to_sseg.vhd) This file was the same as in previous designs. 

[Clock_Divider](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Clock_Divider.vhd) This file was the same as in previous designs. 

[Pinout](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/pinout.ucf) This file was the same as in previous designs.

The bit file used to program the Nexys2 board can be seen in this repository labeled two_elevators.bit under the commit "2elevator2".


#**Editing**

The following files were provided initially.  

[Clock_Divider] (https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Clock_Divider.vhd)  This controls clock functions for the behavior of the elevator design.  This is contained in the Nexys2_top_shell_original.vhd module.  

[Nexys2_top_shell_original] (https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Nexys2_top_shell_original.vhd)   This module combines the functioning of the clock, the converting of nibbles to data that can be output to the seven segment display on the Nexys2, and transfers data to show onto a seven segment display.  This is not finished and surely will have more functionality towards the end of the lab.  The schematic of this shell is shown lower in this README.

[nexys2_sseg_original](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/nexys2_sseg_original.vhd)  This takes data and displays it onto the seven segment display on the Nexys2.   This is contained in the Nexys2_top_shell_original.vhd module.  

[nibble_to_sseg_original] (https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/nibble_to_sseg_original.vhd)  This intakes data in the form of nibbles and converts the data to a form that can be output to a seven segment display on the Nexys2.  This is contained in the Nexys2_top_shell_original.vhd module.  

[pinout_original] (https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/pinout_original.ucf) This module designates the inputs and the outputs of this program to specific locations on the Nexys2 board.  

There was no bad code in the clock divider or the nexys2 top shell files.  

#Bad Code1

This instance of bad code was found in the [nexys2_sseg_original](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/nexys2_sseg_original.vhd) in the process starting at line 64.  The problem with this code is that there is no "when others" case in the case statment, which leaves room for the computer to make assumptions, which is never a good thing. This can create unintentional latches which complicate designs once they get more intricate.  

```vhdl

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
	
```

#Good Code 1
The corrected code can be seen below.  This takes away the opportunity for the computer to create a latch.  

```vhdl

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
				when others => 
				 state_next <= s0;
			end case;
		end if;
	end process;
	
```


#**Documentation Final**
I used this website to figure out how to use the absolute value function in VHDL [ABS_Help](http://www.velocityreviews.com/forums/t376523-how-to-find-the-abs-of-std_logic_vector.html) 

