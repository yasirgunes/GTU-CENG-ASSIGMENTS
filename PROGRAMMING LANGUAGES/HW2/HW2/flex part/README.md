# G++ Lexer Makefile

This Makefile is used to compile and run a lexer for the G++ language. The lexer is generated using Flex and compiled with GCC.

## Makefile Targets

- `flex`: This target generates the lexer from the `.l` file using Flex, compiles the generated C code into an executable using GCC, and runs the executable. The lexer source file is specified by the `FILE` variable in the Makefile.

- `input`: This target runs the lexer on an input file. The input file is specified by the `INPUTFILE` variable in the Makefile.

- `output`: This target runs the lexer on an input file and redirects the output to an output file. The input and output files are specified by the `INPUTFILE` and `OUTPUTFILE` variables in the Makefile, respectively.

## Usage

To generate and run the lexer, use the `flex` target:

```bash
make flex
```

To run the lexer on an input file, use the input target:
```bash
make input
```

To run the lexer on an input file, use the input target:
```bash
make output
```

To do all of it in once:
```bash
make
```
or
```bash
make all
```
