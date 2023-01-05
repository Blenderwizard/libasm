section .text
global _ft_atoi_base

extern _ft_isspace
extern _ft_strlen

_ft_atoi_base:
    PUSH RBP
    MOV RBP, RSP
    XOR RAX, RAX ; ret
    XOR R12, R12 ; inc
    MOV R13, 1   ; sign
	CMP RDI, 0
	JE exit_prog
	CMP RSI, 0
	JE exit_prog
    PUSH RDI
    PUSH RSI
    MOV RDI, RSI
    CALL _ft_strlen
    POP RSI
    POP RDI
	CMP RAX, 1
	JE exit_prog_zero
	XOR RAX, RAX
	JMP verify_base

verify_base_inc:
	INC R12
verify_base:
    CMP BYTE [RSI + R12], 0
	JE verify_base_end
	CMP BYTE [RSI + R12], 9
    JE exit_prog_zero
    CMP BYTE [RSI + R12], 10
    JE exit_prog_zero
    CMP BYTE [RSI + R12], 11
    JE exit_prog_zero
    CMP BYTE [RSI + R12], 12
    JE exit_prog_zero
    CMP BYTE [RSI + R12], 13
    JE exit_prog_zero
    CMP BYTE [RSI + R12], 32
    JE exit_prog_zero
    CMP BYTE [RSI + R12], 43
    JE exit_prog_zero
    CMP BYTE [RSI + R12], 45
    JE exit_prog_zero
	MOV R8, R12
verify_base_no_matching:
	INC R8
	XOR R9B, R9B
	MOV R9B, BYTE [RSI + R8]
    CMP BYTE [RSI + R12] , R9B
	JE exit_prog_zero
    CMP BYTE [RSI + R8], 0
	JNE verify_base_no_matching
    CMP BYTE [RSI + R12], 0
	JNE verify_base_inc
verify_base_end:
	XOR RAX, RAX
	XOR R12, R12
    JMP loop_space

loop_space_inc:
    INC R12
loop_space:
	CMP BYTE [RDI + R12], 9
    JE loop_space_inc
    CMP BYTE [RDI + R12], 10
    JE loop_space_inc
    CMP BYTE [RDI + R12], 11
    JE loop_space_inc
    CMP BYTE [RDI + R12], 12
    JE loop_space_inc
    CMP BYTE [RDI + R12], 13
    JE loop_space_inc
    CMP BYTE [RDI + R12], 32
    JE loop_space_inc
    JMP loop_signs
    
loop_signs_inc_flip:
    NEG R13
loop_signs_inc:
    INC R12
loop_signs:
    CMP BYTE [RDI + R12], 43
    JE loop_signs_inc
    CMP BYTE [RDI + R12], 45
    JE loop_signs_inc_flip

    PUSH RDI
    PUSH RSI
    MOV RDI, RSI
    CALL _ft_strlen
    POP RSI
    POP RDI
    MOV R14, RAX
	XOR RAX, RAX
    JMP loop_base

loop_base_inc:
    INC R12
loop_base:
    XOR R15, R15
    CMP BYTE [RDI + R12], 0
    JE exit_prog
    jmp loop_base_find
    
loop_base_find_inc:
    INC R15
loop_base_find:
    CMP R14, R15
    JE exit_prog
	XOR R9B, R9B
	MOV R9B, BYTE [RSI + R15]
    CMP BYTE [RDI + R12] , R9B
    JNE loop_base_find_inc
    IMUL RAX, R14
    ADD RAX, R15
    JMP loop_base_inc

exit_prog_zero:
	XOR RAX, RAX
exit_prog:
    IMUL RAX, R13
    LEAVE
    RET