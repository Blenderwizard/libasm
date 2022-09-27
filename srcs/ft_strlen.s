section .text
global _ft_strlen

_ft_strlen:
	PUSH	RBP ; establish a stack frame
    MOV		RBP, RSP

	XOR		RAX, RAX ; initialize long = 0
start_loop:
	CMP		BYTE [RDI + RAX], 0 ; str[i] == 0
	JE		exit_prog ; if condition true, exit
	INC		RAX ; i++
	JMP		start_loop ; Continue Loop

exit_prog:
	LEAVE ; Tear down the stack frame
	RET ; Return
