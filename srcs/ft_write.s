section .text
global _ft_write

_ft_write:
	PUSH	RBP ; Establish a stack frame
	MOV		RBP, RSP
	MOV		RAX, 0x2000004 ; Macos is weird, check syscall_sw.h for syscall numbers
	SYSCALL ; Makes the syscal to write

	LEAVE ; Tear down the stack frame
	RET ; Return