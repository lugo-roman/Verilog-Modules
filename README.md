# Verilog-Modules
A collection of Verilog modules for digital design and FPGA development. Includes reusable building blocks for learning, experimentation, and hardware projects.

## Full Adder

**Description:**  
Combinational module that performs the addition of three binary inputs (two operands and one carry input). It produces a sum (`sum`) and a carry output (`cout`).

**Inputs:**  
- `a`: First input bit.  
- `b`: Second input bit.  
- `cin`: Carry input bit.

**Outputs:**  
- `sum`: Result of the addition of the three input bits.  
- `cout`: Carry output of the operation.

## N-bit Adder

**Description:**  
Parametric combinational module that performs binary addition of two *n-bit* operands, including an input carry (`cin`). It outputs the resulting *n-bit* sum and the final carry-out (`cout`).

**Inputs:**
- **a:** First *n-bit* operand.  
- **b:** Second *n-bit* operand.  
- **cin:** Carry input bit.  

**Outputs:**
- **sum:** *n-bit* result of the addition.  
- **cout:** Carry output bit generated from the most significant bit (MSB) addition.
