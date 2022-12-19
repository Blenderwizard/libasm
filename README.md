# A 42 assembly project 

Thank the metaphysical being that can be argued if they exist or not used as an explanation of the unkown to us that Ghidra exists

## Writen Resources
> [Returning a value in x86 assembly](https://stackoverflow.com/questions/55773868/returning-a-value-in-x86-assembly-language)

> [What is a stack frame](https://stackoverflow.com/questions/10057443/explain-the-concept-of-a-stack-frame-in-a-nutshell)

> [Assembly x64 cheat sheet](https://cs.brown.edu/courses/cs033/docs/guides/x64_cheatsheet.pdf)

> [Tutorialspoint assembly programing](https://www.tutorialspoint.com/assembly_programming/index.htm)

> [Which is Better XOR or MOV 0 to set register to 0](https://stackoverflow.com/questions/1135679/does-using-xor-reg-reg-give-advantage-over-mov-reg-0)

> [Intel® 64 and IA-32 Architectures Optimization Reference Manual](http://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-optimization-manual.pdf)

> [MacOS X 64bit Assembly System Calls](http://dustin.schultz.io/mac-os-x-64-bit-assembly-system-calls.html)

```asm
; REFERENCE FOR SYS CALLS
; %eax 	Name		%ebx			%ecx			%edx	%esx	%edi
; 1 	sys_exit 	int 			- 				- 		- 		-
; 2 	sys_fork 	struct pt_regs 	- 				- 		- 		-
; 3 	sys_read 	unsigned int 	char * 			size_t 	- 		-
; 4 	sys_write 	unsigned int 	const char *	size_t 	- 		-
; 5 	sys_open 	const char * 	int 			int 	- 		-
; 6 	sys_close 	unsigned int 	- 				- 		- 		-
```