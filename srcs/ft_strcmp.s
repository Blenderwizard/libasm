section .text
global _ft_strcmp

_ft_strcmp:
	PUSH	RBP ; establish a stack frame
    MOV		RBP, RSP

	; PUSH	
	; CALL	_ft_strlen ; calls 
	LEAVE ; Tears down the stack frame
	RET ; Returns RAX
