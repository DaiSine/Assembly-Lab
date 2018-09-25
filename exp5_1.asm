;调试教材P170例5.6。
;说明：体会非固定次循环的特点。区分出循环体、循环条件、循环变换条件、初始化内容、循环结束后续相关内容。

;***************************************
datarea segment        			           ;define data segment
buffer db 80 dup(?)
flag   db ?
datarea ends
;***************************************
prognam segment                                ; define code segment
;---------------------------------------
main proc far
assume cs:prognam,ds:datarea
start:             				     ;starting execution address
							     ;set up stack for return
       push ds  					     ;save old data address
       sub ax,ax					     ;put zero in AX
       push ax 					     ;save in on stack 
							     ;set DS register to current data segment
       mov ax,datarea
       mov ds,ax
;MAIN PART OF PROGRAM GOES HERE
       lea bx,buffer
       mov flag,0
next:  mov ah,01h
       int 21h
       test flag,01h  
       jnz follow     
       cmp al,20h					     ;空格的ascii码是20h
       jnz exit    
       mov flag,1      
       jmp next
follow:cmp al,20h                    
       jz exit
       mov [bx],al
       inc bx
       jmp next
exit:  ret     				           ;return to DOS
main endp                                      ;end of main part of program
;---------------------------------------
prognam  ends                                  ;end of code segment
;***************************************
        end start                              ;end of assembly