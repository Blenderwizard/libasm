section .text

%ifdef MACOS
global _ft_read
%endif
%ifdef LINUX
global ft_read
%endif

%ifdef MACOS
_ft_read:
%endif
%ifdef LINUX
ft_read:
%endif
	PUSH	RBP ; Establish a stack frame
	MOV		RBP, RSP

%ifdef MACOS
	MOV		RAX, 0x2000003 ; Macos is weird
%endif
%ifdef LINUX
	MOV		RAX, 0x0
%endif
	SYSCALL ; Makes the syscal to write

	LEAVE ; Tear down the stack frame
	RET ; Return