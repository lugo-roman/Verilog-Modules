# Verilog-Modules
A collection of Verilog modules for digital design and FPGA development. Includes reusable building blocks for learning, experimentation, and hardware projects.

## 1. Full Adder

**Description:**  
Combinational module that performs the addition of three binary inputs (two operands and one carry input). It produces a sum (`sum`) and a carry output (`cout`).

**Inputs:**  
- `a`: First input bit.  
- `b`: Second input bit.  
- `cin`: Carry input bit.

**Outputs:**  
- `sum`: Result of the addition of the three input bits.  
- `cout`: Carry output of the operation.

## 2. N-bit Adder

**Description:**  
Parametric combinational module that performs binary addition of two *n-bit* operands, including an input carry (`cin`). It outputs the resulting *n-bit* sum and the final carry-out (`cout`).

**Inputs:**
- **a:** First *n-bit* operand.  
- **b:** Second *n-bit* operand.  
- **cin:** Carry input bit.  

**Outputs:**
- **sum:** *n-bit* result of the addition.  
- **cout:** Carry output bit generated from the most significant bit (MSB) addition.

**Instantiation Format**

- n_bit_adder #(.N(N)) dut(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

## 3. N-bit Subtractor

**Description:**  
Parametric combinational module that performs binary subtraction between two *n-bit* operands, considering an input borrow (`bin`). It outputs the resulting *n-bit* difference and the final borrow-out (`bout`).

**Inputs:**
- **a:** First *n-bit* operand (minuend).  
- **b:** Second *n-bit* operand (subtrahend).  
- **bin:** Borrow input bit.  

**Outputs:**
- **diff:** *n-bit* result of the subtraction.  
- **bout:** Borrow output bit generated from the most significant bit (MSB) operation.
