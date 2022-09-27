section .text
global _ft_strcmp

_ft_strcmp:
	PUSH	RBP ; establish a stack frame
    MOV		RBP, RSP
	XOR		RAX, RAX ; i = 0

loop:
	MOV		DL, BYTE [RSI + RAX]
	CMP		BYTE [RDI + RAX], DL ; string1[i] == string2[i]
	JL		strs_differ_less ; if string1[i] < string2[i]
	JG		strs_differ_great ; if string1[i] > string2[i]  
	CMP		BYTE [RDI + RAX], 0 ; if string1[i] == 0 and string1[i] == string2[i], then strings same
	JE		strs_same ; if condition true, exit
	INC		RAX ; i++
	JMP		loop ; Continue Loop

strs_differ_less:
	XOR		RAX, RAX ; Set rax to negative 1
	DEC		RAX
	JMP		exit_prog

strs_differ_great:
	XOR		RAX, RAX ; Set rax to positive 1
	INC		RAX
	JMP		exit_prog

strs_same:
	XOR		RAX, RAX

exit_prog:
	LEAVE ; Tear down the stack frame
	RET ; Return
