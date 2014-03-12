ECE281_Lab3
===========
#**Prelab**
The purpose of the prelab was to acquire a basic understanding for the archtecture of the program describing the behavior of an elevator.  

The following files were provided initially.  

[Clock_Divider] (https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Clock_Divider_original.vhd)  This controls clock functions for the behavior of the elevator design.  This is contained in the Nexys2_top_shell_original.vhd module.  

[Nexys2_top_shell_original] (https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Nexys2_top_shell_original.vhd)   This module combines the functioning of the clock, the converting of nibbles to data that can be output to the seven segment display on the Nexys2, and transfers data to show onto a seven segment display.  This is not finished and surely will have more functionality towards the end of the lab.  The schematic of this shell is shown lower in this README.

[nexys2_sseg_original](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/nexys2_sseg_original.vhd)  This takes data and displays it onto the seven segment display on the Nexys2.   This is contained in the Nexys2_top_shell_original.vhd module.  

[nibble_to_sseg_original] (https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/nibble_to_sseg_original.vhd)  This intakes data in the form of nibbles and converts the data to a form that can be output to a seven segment display on the Nexys2.  This is contained in the Nexys2_top_shell_original.vhd module.  

[pinout_original] (https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/pinout_original.ucf) This module designates the inputs and the outputs of this program to specific locations on the Nexys2 board.  

Note: All of this code was created by an outside source, therefore, everything was left exactly how it was downloaded.  The headers were only slightly altered.

#Prelab Schematic
Below shows the current structure of the module Nexys2_top_shell.vhd that was given in the assignment.  

 ![alt tag](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Prelab%20Schematic1.jpg "Prelab Schematic of Nexys2_top_shell.vhd")

Note: Because the design is not finished, there are many hanging inputs, meaning that the inputs have not be specified.  These inputs include, but are not limited to, btn(3:0) and switch (7:0).  Also, the internal signals nibble0(3:0), nibble1(3:0), nibble2(3:0), and nibble3(3:0) are necessary for the design but appear to come from nowhere in the schematic.  This is because their origin has not been specified yet. 

The only components shown in this diagram are the ones that were in the original Nexys2_top_shell.vhd file here: [Nexys2_top_shell_original] (https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Nexys2_top_shell_original.vhd) This is the same file shown in the beginning.  Again, it is unaltered from the original.  

#Documentation: Prelab
NONE


#**Remainder of Lab**
Using the files from computer excercise three, the actual logic for defining the behavior of an elevator was imported.  Using this logic, an immitation of an elevator was created on the Nexys2 board.  This logic was initially created using a Moore machine.  The file for this logic can be seen here: [Moore Behavioral File](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/MooreElevatorControllerCE3.vhd) This file was altered, however, from the original CE3 file logic.  It was modified to be able to handle floors 1-8 instead of just floors 1-4.  Aside from this, no changes were made.  The original file can be seen here: [Original Moore Logic](https://raw.github.com/JohnTerragnoli/ECE281_CE3/master/MooreElevatorController_Shell.vhd)

