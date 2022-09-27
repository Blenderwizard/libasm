section .text
global _ft_read

_ft_read:
	PUSH	RBP ; Establish a stack frame
	MOV		RBP, RSP
	MOV		RAX, 0x2000003 ; Macos is weird
	SYSCALL ; Makes the syscal to write

	LEAVE ; Tear down the stack frame
	RET ; Return