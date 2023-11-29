section .text

%ifdef MACOS
global _ft_strcpy
%endif
%ifdef LINUX
global ft_strcpy
%endif

%ifdef MACOS
_ft_strcpy:
%endif
%ifdef LINUX
ft_strcpy:
%endif
	PUSH	RBP ; Establish stack frame
	MOV		RBP, RSP
	XOR		RAX, RAX ; i = 0

loop:
	MOV		DL, BYTE [RSI + RAX] ; a = string2[i]
	MOV		BYTE [RDI + RAX], DL ; string1[i] = a
	CMP		DL, 0 ; exit loop if a == '\x00'
	JE		exit_prog
	INC		RAX ; i++
	JMP 	loop ; Continue loop

exit_prog:
	MOV RAX, RDI ; ret string1
	LEAVE ; Tear down stack frame
	RET ; Return