section .text
global	_ft_strdup
extern	_ft_strlen
extern 	_malloc

_ft_strdup:
	PUSH	RBP ; Establish a stack frame
	MOV 	RBP, RSP
	CALL 	_ft_strlen ; Get size to allocate
	PUSH	RDI ; Save RDI for later
	PUSH	0 ; Keep stack alligned
	MOV 	RAX, RDI ; Set first parameter to return of ft_strlen
	CALL	_malloc ; Allocate
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

exit_prog:
	LEAVE
	RET