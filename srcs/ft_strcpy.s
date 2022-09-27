section .text
global _ft_strcpy

_ft_strcpy:
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