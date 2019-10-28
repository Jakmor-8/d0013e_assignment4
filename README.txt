README

To run this program, go to program folder in directory and invoke the "make" command to create the .objdump file. 
Open Syncsim in the piped extended mode and select the created .objdump file within syncsim,
in the case of multiple divisions, add breakpoints in the instruction memory and then hit run in syncsim.
The resulting fraction will be found in register v0 and the remainder in register v1.

To specify your own dividend and divisor, open the division.s file in the program folder and edit within the main function,
register a0 is the dividend and register a1 is the divisor.
Once done, save the file and repeat the "To run this program" instructions again.

On division with zero the program will crash and have to be manually restarted.

