section .text
global _ft_atoi_base

extern _ft_isspace
extern _ft_strlen

_ft_atoi_base:
    PUSH RBP ; Establish stack fraim
    MOV RBP, RSP
    XOR RAX, RAX ; int ret = 0
    XOR R12, R12 ; int i = 0
    MOV R13, 1   ; int sign = 1
	CMP RDI, 0 ; if (s == NULL) return 0
	JE exit_prog 
	CMP RSI, 0 ; if (base == NULL) return 0
	JE exit_prog
    PUSH RDI
    PUSH RSI
    MOV RDI, RSI
    CALL _ft_strlen ; get len of base
    POP RSI
    POP RDI
	CMP RAX, 1 ; base len = 1, invalid
	JE exit_prog_zero
	XOR RAX, RAX ; reset RAX
	JMP verify_base

verify_base_inc:
	INC R12
verify_base: ; if base isspace or + or -, invalid
    CMP BYTE [RSI + R12], 0 ; if base[i] == '\x00' base vaid
	JE verify_base_end
	CMP BYTE [RSI + R12], 9 ; if isspace(base[i]) => ret 0
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
    CMP BYTE [RSI + R12], 43 ; if base[i] == '+' => ret 0
    JE exit_prog_zero
    CMP BYTE [RSI + R12], 45 ; if base[i] == '-' => ret 0
    JE exit_prog_zero
	MOV R8, R12
verify_base_no_matching: ; check if any remain match current
	INC R8
	XOR R9B, R9B
	MOV R9B, BYTE [RSI + R8]
    CMP BYTE [RSI + R12] , R9B ; if base[i] == base[j] => ret 0
	JE exit_prog_zero
    CMP BYTE [RSI + R8], 0 ; if base[j] != '\x00' continue checking matches
	JNE verify_base_no_matching
    CMP BYTE [RSI + R12], 0 ; if base[i] != '\x00' continue checking base
	JNE verify_base_inc
verify_base_end: ; base valid
	XOR RAX, RAX ; reset ret
	XOR R12, R12 ; reset i
    JMP loop_space

loop_space_inc:
    INC R12
loop_space: ; skip spaces
	CMP BYTE [RDI + R12], 9 ; if isspace(s[i]) => skip
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
    INC R12 ; sign *= -1
loop_signs: 
    CMP BYTE [RDI + R12], 43 ; if s[i] == '+' => skip
    JE loop_signs_inc
    CMP BYTE [RDI + R12], 45 ; if s[i] == '-' => skip and invert
    JE loop_signs_inc_flip

    PUSH RDI
    PUSH RSI
    MOV RDI, RSI
    CALL _ft_strlen ; get strlen of base
    POP RSI
    POP RDI
    MOV R14, RAX
	XOR RAX, RAX
    JMP loop_base

loop_base_inc:
    INC R12
loop_base:
    XOR R15, R15
    CMP BYTE [RDI + R12], 0 ; if s[i] == '\x00' => ret size
    JE exit_prog
    jmp loop_base_find
    
loop_base_find_inc:
    INC R15
loop_base_find:
    CMP R14, R15 ; if j = base len, not part of base => ret size
    JE exit_prog
	XOR R9B, R9B
	MOV R9B, BYTE [RSI + R15]
    CMP BYTE [RDI + R12] , R9B ; if base[j] == s[i] => we found the number add it
    JNE loop_base_find_inc
    IMUL RAX, R14 ; ret *= base len
    ADD RAX, R15 ; ret += found number
    JMP loop_base_inc

exit_prog_zero:
	XOR RAX, RAX ; incase of error return 0
exit_prog:
    IMUL RAX, R13 ; total *= sign
    LEAVE ; Tear down stack frame
    RET ; Return