section .text

%ifdef MACOS
global	_ft_strdup
extern	_ft_strlen
extern  _malloc
%endif
%ifdef LINUX
global	ft_strdup
extern	ft_strlen
extern  malloc
%endif

%ifdef MACOS
_ft_strdup:
%endif
%ifdef LINUX
ft_strdup:
%endif
	PUSH	RBP ; Establish a stack frame
	MOV 	RBP, RSP
	CMP		RDI, 0 ; If Parametered string is null, return
	JE		exit_prog_null_string
%ifdef MACOS
	CALL 	_ft_strlen ; Get size to allocate
%endif
%ifdef LINUX
	CALL	ft_strlen
%endif
	PUSH    RDI ; Save RDI for later
	PUSH	0 ; Keep stack alligned
	MOV 	RDI, RAX ; Set first parameter to return of ft_strlen
	INC		RDI
%ifdef MACOS
	CALL	_malloc wrt ..plt ; Allocate
%endif
%ifdef LINUX
	CALL    malloc wrt ..plt; Allocate
%endif
	POP		RDI ; Get rid of dummy
	POP		RDI ; Retrieve parameter
	CMP		RAX, 0 ; If malloc returned null, error out
	JE		exit_prog
	XOR		RCX, RCX ; i = 0

loop:
	MOV		DL, BYTE [RDI + RCX] ; newstring[i] = oldstring[i]
	MOV		BYTE [RAX + RCX], DL
	INC		RCX ; i++
	CMP		DL, 0 ; oldstring[i] == '\x00'
	JNE		loop ; if false continue
	JE		exit_prog ; if true exit

exit_prog_null_string:
	XOR		RAX,RAX

exit_prog:
	LEAVE
	RET
