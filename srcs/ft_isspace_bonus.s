section .text
global _ft_isspace

_ft_isspace:
    PUSH RBP
    MOV RSP, RBP
    XOR RAX, RAX

    CMP RDI, 9
    JE isspace
    CMP RDI, 10
    JE isspace
    CMP RDI, 11
    JE isspace
    CMP RDI, 12
    JE isspace
    CMP RDI, 13
    JE isspace
    CMP RDI, 32
    JE isspace
    JMP exit_prog

isspace:
    INC RAX
exit_prog:
    LEAVE
    RET
