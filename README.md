# Gaufre programming language
Yet another simple esoteric language.

# Instructions - Opcodes

`#: Exit`

`## : Increment memory cell X times (1 argument)`

`### : Decrement memory cell X times (1 argument)`

`#### : Move left the memory cursor X times (1 argument)`

`##### :Move right the memory cursor X times (1 agument)`

`###### : Go to line X (1 Argument)`

`####### : Is A == B ? Then Go to line X else do nothing (3 arguments: A - B - X )`

`######## : Print a char (1 argument)`

`######### : Get a char from the console input and place it to the current memory cell (char id to ASCII)`

If there no argument provided, Gaufre will use the value of the current selected cell instead.
