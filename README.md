Parameterized ALU — RTL Design and Verification

Overview
A parameterized Arithmetic Logic Unit (ALU) designed in Verilog RTL and functionally verified using a structured testbench. 
The testbench instantiates both the DUT and a reference model simultaneously, and a scoreboard automatically compares their outputs for every transaction.

Features

Parameterized operand width (default 8-bit, 4-bit command bus) Supports arithmetic operations — ADD, SUB, ADD with carry, SUB with carry, increment, decrement, 
compare, signed ADD, signed SUB, and multiply variants Supports logical operations — AND, NAND, OR, NOR, XOR, XNOR, NOT, shift, and rotate Active high asynchronous 
reset and clock enable support ERR flag for invalid input conditions and out-of-range rotate amounts Self-checking testbench with reference model and scoreboard Coverage analysis using Questa SIM

Tools

Questa sim
