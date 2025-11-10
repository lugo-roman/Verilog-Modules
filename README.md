# Verilog-Modules
A collection of Verilog modules for digital design and FPGA development. Includes reusable building blocks for learning, experimentation, and hardware projects.

### Full Adder

**Descripción:**  
Módulo combinacional que realiza la suma de tres bits (dos operandos y un acarreo de entrada). Genera una salida de suma (`sum`) y un acarreo de salida (`cout`).

**Entradas:**  
- `a`: Primer bit de entrada.  
- `b`: Segundo bit de entrada.  
- `cin`: Bit de acarreo de entrada.

**Salidas:**  
- `sum`: Resultado de la suma de los tres bits de entrada.  
- `cout`: Acarreo resultante de la operación.

**Ecuaciones lógicas:**  
- `sum  = a ^ b ^ cin`  
- `cout = (a & b) | (a & cin) | (b & cin)`
