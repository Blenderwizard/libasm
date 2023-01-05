section .text
global _ft_list_size

_ft_list_size:
	PUSH	RBP ; Establish a stack frame
    MOV		RBP, RSP
    XOR     RAX, RAX

loop:
    CMP     RDI, 0 ; if pointer == NULL
    JE      exit_prog
    MOV     RDI, [RDI + 8] ; current = current.next
	INC		RAX ; i++
	JMP		loop ; Continue Loop

exit_prog:
	LEAVE ; Tear down the stack frame
	RET ; Return
