# Virtual assembly file
# Test variable declarations, labels and all available commands

.STACK = 1024;

.DATA

# Variables section
CHAR var;
CHAR var;
CHAR var;

CHAR str1[] = "Hello World!";
CHAR ch1 = 'A';

BYTE bVal1;

BYTE bVal0;
BYTE bVal1 = 1;
BYTE bVal2 = 127;
BYTE bVal3[] = 0x4F,0x0F;
BYTE bVal4[10] = 10, 20, 30, 40, 50, 60, 70, 80, 90, 0x10;

WORD wVal1;

WORD wVal1;
WORD wVal2 = 10000;
WORD wVal3 = 0x0100;
WORD wVal4[5] = 100, 200, 300, 400;

DWORD dwVal1 = -1;
DWORD dwVal2 = 10000000;
DWORD dwVal3 = 0xA0B0C0D;
DWORD dwVal4[5];
DWORD dwVal5[4] = 0, 100, 0, 0xAAAAAAA;

QWORD qwVal1 = -10;
QWORD qwVal2 = 1000000000;
QWORD qwVal3 = 0x1080A0B0C0D0E0F;
QWORD qwVal4[5];
QWORD qwVal5 = 0xFFFFFFFFFFFFFF;
QWORD qwVal6 = 0x80000000000000;
QWORD qwVal7[4] = 0, 0xFFFF, 0, 188900967592960;

.CODE

Func F1;
Func F2;

Func Main:
    PUSHSF;
    JUMP start;
    NOP;
    NOP;
    NOP;
start:
    ASSIGN A7, null;
    ASSIGN A4, F1;
    CALL A4;
    ASSIGN A4, F2;
    CALL A4;
    POPSF;
    RET;
EndF

Func F1 :
    ASSIGN QW R0, 0x0F0E0D0C0B0A0908;
    ASSIGN QW R8, 0x0102030405060708;
    ASSIGN R16, 10000;

    MOVE R20, R0;
    MOVE B R20, R0;
    MOVE W R20, R0;
    MOVE DW R20, R0;
    MOVE QW R24, R0;

    SWAP R20, R28;
    SWAP B R20, R28;
    SWAP W R20, R28;
    SWAP DW R20, R28;
    SWAP QW R16, R24;

Label1:
    AND R0,R8;
    AND B  R0,R8;
    AND W  R0,R8;
    AND DW R0,R8;
    AND QW R0,R8;

    JZ Label2;

    ADD R0,R8;
    ADD B  R0,R8;
    ADD W  R0,R8;
    ADD DW R0,R8;
    ADD QW R0,R8;

Label2:
    PUSH R0;
    POP R28;
    PUSH B R0;
    POP B R28;
    PUSH W R0;
    POP W R28;
    PUSH DW R0;
    POP DW R28;
    PUSH QW R0;
    POP QW R24;
    GFLR R16;
    SFLR R16;

    RET;
EndF

Func F2:
    # PUSHSF 0x10;
    INC A0, R0;
    INC A0, 16;
    DEC A4, 10;
    DEC A4, R4;

    # STAE W R8;
    # NOT  W R8;

    ASSIGN B R1, 4;
    SHL W R6, 5;
    SHR W R6, R1;
    ROL W R6, 7;
    ROR W R6, R1;
    SAL W R6, 3;
    SAR W R6, R1;
    RCL W R6, 1;
    RCR W R6, R1;

    ADC R8, R12;
    SBB R8, R12;
    MUL R8, R12;
    IMUL R8, R12;
    DIV R8, R12;
    IDIV R8, R12;
    NEG QW R8;

    CAST W DW R4;
    CAST DW W R16;

    ASSIGN A4,bVal1;
    ASSIGN A5,wVal1;
    ASSIGN A6,dwVal1;
    ASSIGN A7,qwVal1;

    LOAD B R0,A4;
    LOAD W R0,A5;
    LOAD DW R0,A6;
    LOAD QW R0,A7;

    STORE B R10,A4;
    STORE W R10,A5;
    STORE DW R12,A6;
    STORE QW R16,A7;

    # LDREL A6, SP, +10;
    # STREL A6, SP, -10;

    OUT R0,0;
    OUT W R40,1024;
Loop:
    IN R0,1;
    IN W R44,4095;
    BREAK;
    ASSIGN R4, 0;
    CMP R0, R4;
    JNE Loop;

    TEST R0, R0;
    JZ Exit;
    BREAK;

Exit:
    POPSF;
    RET;
EndF

.MAIN = Main;