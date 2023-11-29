section .text

%ifdef MACOS
global _ft_read
extern ___error
%endif
%ifdef LINUX
global ft_read
extern __errno_location
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
	SYSCALL ; Makes the syscall to read
	TEST	RAX, RAX
	JS	 	exit_error

	LEAVE ; Tear down the stack frame
	RET ; Return

exit_error:
    NEG  	RAX ; get errno value (is negative need positive)
	MOV		R15, RAX ; store RAX
	SUB	 	RSP, 0x8
%ifdef MACOS
	CALL	___error ; get errno location
%endif
%ifdef LINUX
    CALL	__errno_location wrt ..plt ; get errno location
%endif
    MOV		[RAX], R15 ; move errno error into errno location
	ADD		RSP, 0x8
    POP		RBX
    MOV		RAX, -1
    LEAVE
    RET