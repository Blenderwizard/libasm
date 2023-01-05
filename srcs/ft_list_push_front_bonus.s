section .text
global _ft_list_push_front

extern _malloc

_ft_list_push_front:
	PUSH RBP ; Establish a stack frame
    MOV	RBP, RSP
    PUSH RDI
	PUSH RSI
	MOV RDI, 16 ; sizeof(t_list)
	CALL _malloc
	POP RSI
	POP RDI
	CMP RAX, 0 
	JE exit_prog
	MOV RAX, RSI
	MOV [RAX + 8], RDI

exit_prog:
	LEAVE ; Tear down the stack frame
	RET ; Return
