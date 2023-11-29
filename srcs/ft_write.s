section .text

%ifdef MACOS
global _ft_write
%endif
%ifdef LINUX
global ft_write
%endif

%ifdef MACOS
_ft_write:
%endif
%ifdef LINUX
ft_write:
%endif
	PUSH	RBP ; Establish a stack frame
	MOV		RBP, RSP
%ifdef MACOS
	MOV		RAX, 0x2000004 ; Macos is weird, check syscall_sw.h for syscall numbers
%endif
%ifdef LINUX
	MOV		RAX, 0x1 
%endif
	SYSCALL ; Makes the syscal to write

	LEAVE ; Tear down the stack frame
	RET ; Return