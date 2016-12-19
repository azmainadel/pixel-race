.MODEL SMALL
.STACK 100H

;declaring line macro
DRAW_LINE MACRO X,Y,Z,COLOR
    LOCAL LINE    
    MOV AH,0CH
    MOV AL,COLOR
    MOV CX,X     
    MOV DX,Y     
    
    LINE: 
        INT 10H
        INC CX
        CMP CX,Z
        JL LINE
ENDM

;declaring car macro
DRAW_CAR MACRO C1,C2,R1,R2,COLOR
    LOCAL CAR,EXIT
    MOV AH,0CH
    MOV AL,COLOR
    MOV DX,R1
    
    CAR:
        CMP DX,R2
        JG EXIT
    
        DRAW_LINE C1,DX,C2,COLOR
        INC DX
        JMP CAR
 
    EXIT:
ENDM    

.DATA

CAR_POSITION DB 1
CAR1_COLUMN1 DW 280
CAR1_COLUMN2 DW 320
CAR2_COLUMN1 DW 190
CAR2_COLUMN2 DW 230
CAR3_COLUMN1 DW 280
CAR3_COLUMN2 DW 320

POINT DW 0
REM DW 0
CR EQU 0DH
LF EQU 0AH

NEW_1 DW 0
NEW_2 DW 0
NEW_3 DW 0

.CODE

DRAW_START PROC
    MOV AH, 0
    MOV AL, 13H
    INT 10H
    
    ;SELECT PALETTE    
    MOV AH, 0BH
    MOV BH, 1
    MOV BL, 0
    INT 10H
    
    ;SET BGD COLOR
    MOV BH, 0
    MOV BL, 0; 
    INT 10H
    
    
    MOV AH,6
    XOR AL,AL
    XOR CX,CX
    MOV DX,184FH
    MOV BH,0
    INT 10H
    
    MOV CX,368
    NEW_LINE3:
       MOV DL,' '
       INT 21H
       LOOP NEW_LINE3
       
    MOV DL,'P'
    INT 21H 
    MOV DL,'r'
    INT 21H
    MOV DL,'e'
    INT 21H
    MOV DL,'s'
    INT 21H
    MOV DL,'s'
    INT 21H
    MOV DL,' '
    INT 21H
    MOV DL,'A'
    INT 21H
    MOV DL,'n'
    INT 21H
    MOV DL,'y'
    INT 21H
    MOV DL,' '
    INT 21H
    MOV DL,'K'
    INT 21H
    MOV DL,'e'
    INT 21H
    MOV DL,'y'
    INT 21H
    MOV DL,' '
    INT 21H
    MOV DL,'T'
    INT 21H
    MOV DL,'o'
    INT 21H
    MOV DL,' '
    INT 21H
    MOV DL,'S'
    INT 21H
    MOV DL,'t'
    INT 21H
    MOV DL,'a'
    INT 21H
    MOV DL,'r'
    INT 21H
    MOV DL,'t'
    INT 21H
     
    RET
    
DRAW_START ENDP

DRAW_LINES PROC
    MOV AH, 0
    MOV AL, 13H
    INT 10H
    
    ;DRAW THE TWO LINES 
    DRAW_LINE 0,63,319,15
    DRAW_LINE 0,126,319,15
     
    RET
    
    DRAW_LINES ENDP


CAR_CONTROL PROC
    MOV AL,CAR_POSITION
    
    CMP AL,0
    JE DRAW_AT_0
    
    CMP AL,1
    JE DRAW_AT_1
    
    CMP AL,2
    JE DRAW_AT_2
    
    JMP KEYBOARD
    
    DRAW_AT_0:
        DRAW_CAR 0,40,20,40,12
        JMP KEYBOARD
    
    DRAW_AT_1:
        DRAW_CAR 0,40,80,100,12
        JMP KEYBOARD
    
    DRAW_AT_2:
        DRAW_CAR 0,40,160,180,12
        JMP KEYBOARD
    
    KEYBOARD: 
        MOV AH,06H
        MOV DL,0FFH
        INT 21H

   CMP AL,72
   JNE CHECK_DOWN
   CALL GO_UP
   JMP EXIT_MY_CAR
   
   CHECK_DOWN:
        CMP AL,80
        JNE EXIT_MY_CAR
        CALL GO_DOWN
   
   EXIT_MY_CAR:
   RET

CAR_CONTROL ENDP


GO_UP PROC 
    MOV AL,CAR_POSITION
    CMP AL,1
    JE GOTO_POS_0_UP
    CMP AL,2
    JE GOTO_POS_1_UP
    JMP EXIT_UP
    
    GOTO_POS_0_UP:    
        DRAW_CAR 0,40,80,100,0 
        DRAW_CAR 0,40,20,40,12
        MOV CAR_POSITION,0 
        JMP EXIT_UP
    
    GOTO_POS_1_UP:
        DRAW_CAR 0,40,160,180,0
        DRAW_CAR 0,40,80,100,12
        MOV CAR_POSITION,1
        JMP EXIT_UP  
    
    EXIT_UP:
    
    RET
    
GO_UP ENDP 
    
GO_DOWN PROC 
    MOV AL,CAR_POSITION
    CMP AL,0
    JE GOTO_POS_1_DOWN
    CMP AL,1
    JE GOTO_POS_2_DOWN
    JMP EXIT_DOWN
    
    GOTO_POS_1_DOWN: 
        DRAW_CAR 0,40,20,40,0
        DRAW_CAR 0,40,160,180,0 
        DRAW_CAR 0,40,80,100,12
        MOV CAR_POSITION,1 
        JMP EXIT_DOWN
    
    GOTO_POS_2_DOWN: 
        DRAW_CAR 0,40,80,100,0 
        DRAW_CAR 0,40,160,180,12
        MOV CAR_POSITION,2 
        JMP EXIT_DOWN  
        
    EXIT_DOWN:
    
    RET
    
GO_DOWN ENDP

SHOW_SCORE PROC
    ;CLEAR SCREEN
    MOV AH,6
    XOR AL,AL
    XOR CX,CX
    MOV DX,184FH
    MOV BH,0
    INT 10H
    
    MOV CX,375
    NEW_LINE1:
       MOV DL,' '
       INT 21H
       LOOP NEW_LINE1
       
    MOV DL,'G'
    INT 21H 
    MOV DL,'A'
    INT 21H
    MOV DL,'M'
    INT 21H
    MOV DL,'E'
    INT 21H
    MOV DL,' '
    INT 21H
    MOV DL,'O'
    INT 21H
    MOV DL,'V'
    INT 21H
    MOV DL,'E'
    INT 21H
    MOV DL,'R'
    INT 21H
     
    MOV CX,69
    NEW_LINE2:
       MOV DL,' '
       INT 21H
       LOOP NEW_LINE2
    
    MOV DL,'Y'
    INT 21H
    MOV DL,'o'
    INT 21H
    MOV DL,'u'
    INT 21H
    MOV DL,'r'
    INT 21H
    MOV DL,' '
    INT 21H
    
    MOV DL,'S'
    INT 21H
    MOV DL,'c'
    INT 21H
    MOV DL,'o'
    INT 21H
    MOV DL,'r'
    INT 21H
    MOV DL,'e'
    INT 21H
    MOV DL,' '
    INT 21H
    MOV DL,':'
    INT 21H
    MOV DL,' '
    INT 21H
    
    XOR CX,CX
    MOV AX,POINT
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    OR AX,AX
    JGE END_IF1
    
    PUSH AX
    MOV DL,'-'
    MOV AH,2
    INT 21H
    POP AX
    NEG AX

    END_IF1:
        XOR CX,CX
        MOV BX,10D

    REPEAT1:
        XOR DX,DX
        DIV BX
        PUSH DX
        INC CX
        OR AX,AX
        JNE REPEAT1

    MOV AH,2

    PRINT_LOOP:
        POP DX
        OR DL,30H
        INT 21H
        LOOP PRINT_LOOP

    POP DX
    POP CX
    POP BX
    POP AX
    
    MOV AH,0
    INT 16H
         
    MOV AX,3
    INT 10H 
    MOV AH,4CH
    INT 21H
    
    RET

SHOW_SCORE ENDP


GAME PROC
    CALL DRAW_LINES
    
    INFINITE_LOOP:
        CMP CAR1_COLUMN1,0
        JE SET_FIRST_CAR
        JMP END_SET_1
    
    SET_FIRST_CAR:
        DRAW_CAR 0,40,20,40,0
        MOV CAR1_COLUMN1,280
        MOV CAR1_COLUMN2,320
    
        MOV AL,CAR_POSITION
        XOR AH,AH
        CMP AX,0
        JNE EXIT_ONE
        CALL SHOW_SCORE
    
        JMP EXIT_ONE
    
        END_SET_1: 
            DRAW_CAR CAR1_COLUMN1,CAR1_COLUMN2,20,40,10
            XOR AX,AX
            MOV AX,CAR1_COLUMN2
            ADD AX,1
            MOV NEW_1,AX
            DRAW_CAR NEW_1,320,20,40,0
    
            DEC CAR1_COLUMN1
            DEC CAR1_COLUMN2
            CALL CAR_CONTROL
  
            JMP FIRST_CAR_RUNNING  

        EXIT_ONE:
            DRAW_CAR 0,320,20,50,0
            INC POINT
            DRAW_CAR 0,320,20,50,0
    
        FIRST_CAR_RUNNING:
            CMP CAR2_COLUMN1,0
            JE SET_SECOND_CAR
            JMP END_SET_2
    
            
    SET_SECOND_CAR:
        DRAW_CAR 0,40,80,100,0
        MOV CAR2_COLUMN1,280
        MOV CAR2_COLUMN2,320
    
        MOV AL,CAR_POSITION
        XOR AH,AH
        CMP AX,1
        JNE EXIT_TWO
        CALL SHOW_SCORE
    
        JMP EXIT_TWO
    
        END_SET_2:
            DRAW_CAR CAR2_COLUMN1,CAR2_COLUMN2,80,100,10
            XOR AX,AX
            MOV AX,CAR2_COLUMN2
            ADD AX,1
            MOV NEW_2,AX
            DRAW_CAR NEW_2,320,80,110,0
    
            DEC CAR2_COLUMN1
            DEC CAR2_COLUMN2
            CALL CAR_CONTROL
  
            JMP SECOND_CAR_RUNNING  

        EXIT_TWO:
            DRAW_CAR 0,320,80,110,0
            INC POINT
            DRAW_CAR 0,320,80,110,0
    
        SECOND_CAR_RUNNING:
            CMP CAR3_COLUMN1,0
            JE SET_THIRD_CAR
            JMP END_SET_3
    
            
    SET_THIRD_CAR:
        DRAW_CAR 0,40,160,180,0
        MOV CAR3_COLUMN1,280
        MOV CAR3_COLUMN2,320
    
        MOV AL,CAR_POSITION
        XOR AH,AH
        CMP AX,2
        JNE EXIT_THREE
        CALL SHOW_SCORE
    
        JMP EXIT_THREE
    
        END_SET_3:
            DRAW_CAR CAR3_COLUMN1,CAR3_COLUMN2,160,180,10
            XOR AX,AX
            MOV AX,CAR3_COLUMN2
            ADD AX,1
            MOV NEW_3,AX
            DRAW_CAR NEW_3,320,160,180,0
    
            DEC CAR3_COLUMN1
            DEC CAR3_COLUMN2
            CALL CAR_CONTROL
    
            JMP THIRD_CAR_RUNNING    

        EXIT_THREE:
            DRAW_CAR 0,320,160,190,0
            INC POINT
    
        THIRD_CAR_RUNNING:
 
    JMP INFINITE_LOOP


GAME ENDP



MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    CALL DRAW_START
    
    MOV AH,0
    INT 16H
    CMP AH,115
    JE START
    
    START:
        CALL GAME

    MAIN ENDP
    
END MAIN

;FINNNNNNNNNNISH