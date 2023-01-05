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
	CMP RAX, 0 ; malloc returned null, exit
	JE exit_prog
	MOV RAX, RSI ; new_list_node.data = data
	MOV [RAX + 8], RDI ; new_list_node.next = begin_list

exit_prog:
	XOR RAX, RAX ; function does not return, setting to 0
	LEAVE ; Tear down the stack frame
	RET ; Return
