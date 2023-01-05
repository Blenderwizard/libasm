section .text
global _ft_atoi_base

extern _ft_isspace
extern _ft_strlen

_ft_atoi_base:
    PUSH    RBP
    MOV     RSP, RBP
    XOR     RAX, RAX ; ret
    XOR     R12, R12 ; inc
    MOV     R13, 1   ; sign
    JMP     loop_space 
loop_space_inc:
    INC R12
loop_space:
    PUSH RDI
    PUSH RSI
    MOV [RDI + R12], RDI
    CALL _ft_isspace
    CMP RAX, 1
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
    MOV RSI, RDI
    CALL _ft_strlen
    POP RSI
    POP RDI
    MOV R14, RAX
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
    CMP [RSI + R15], [RDI + R12]
    JNE loop_base_find_inc
    CMP R14, R15
    JE exit_prog
    IMUL R14, RAX
    ADD R15, RAX
    JMP loop_base_inc
exit_prog:
    IMUL R13, RAX
    LEAVE
    RET