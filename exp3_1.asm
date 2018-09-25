MYDATA     SEGMENT                            ;定义数据段
GRAY    DB     18H, 34H, 05H, 06H, 09H
        DB     0AH, 0CH,11H, 12H, 14H
MYDATA      ENDS
 
MYCODE      SEGMENT
ASSUME      CS: MYCODE, DS: MYDATA
GO:           MOV         AX, MYDATA
              MOV         DS, AX
              MOV         BX, OFFSET   GRAY
              MOV         CX, 2
CYCLE:        IN           AL, 21H   ;从21H号端口输入8位数据到AL寄存器；
              XLAT        GRAY
              AND          AL, 7FH  ;  输入数据的最高位置0；
              OUT          21H, AL  ; 将置0后的数据从21H号端口输出
              LOOP        CYCLE
              RET
MYCODE        ENDS
              END          GO
                                        ;20161724_代欣月_实验3
