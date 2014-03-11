ECE281_Lab3
===========
#**Prelab**
The purpose of the prelab was to acquire a basic understanding for the archtecture of the program describing the behavior of an elevator.  

The following files were provided initially.  

[Clock_Divider] (https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Clock_Divider_original.vhd)

[Nexys2_top_shell_original] (https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Nexys2_top_shell_original.vhd) 

[nexys2_sseg_original](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/nexys2_sseg_original.vhd)

[nibble_to_sseg_original] (https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/nibble_to_sseg_original.vhd)

[pinout_original] (https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/pinout_original.ucf)

Note: All of this code was created by an outside source, therefore, everything was left exactly how it was downloaded.  

#Prelab Schematic
Below shows the current structure of the module Nexys2_top_shell.vhd that was given in the assignment.  

 ![alt tag](https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Prelab%20Schematic1.jpg "Prelab Schematic of Nexys2_top_shell.vhd")

Note: Because the design is not finished, there are many hanging inputs, meaning that the inputs have not be specified.  These inputs include, but are not limited to, btn(3:0) and switch (7:0).  Also, the inputs nibble0(3:0), nibble1(3:0), nibble2(3:0), and nibble3(3:0) are necessary for the design but appear to come from no where in the schematic.  This is because their origin has not been specified yet. 
The only components shown in this diagram are the ones that were in the original Nexys2_top_shell.vhd file here: [Nexys2_top_shell_original] (https://raw.github.com/JohnTerragnoli/ECE281_Lab3/master/Nexys2_top_shell_original.vhd) 

#Documentation: Prelab
NONE
