;1.	在缓冲区中输入20字符，然后按ASCII值从大到小的顺序排列并显示出来。
要求：
;（1）显示时每个字符间隔一个空格；
;（2）换行后再将其中的数字按序显示出来。
data segment                                      ;定义数据段
str         db 'please input a string:$'          ;串结束符$
str1        db 20
str1n       db ?
str1s       db 20 dup(?)
crlf        db 0ah,0dh,'$'

sortresult db "The sort result:"   
           db  40 dup(?)                          ;排序结果
           db  '$'
numresult  db  "The sort result of integer:"
           db  20 dup(?)                         
           db  '$'                                ;数字排序结果
data ends

stacks segment                                    ;定义堆栈段
       db 200 dup(?)
stacks ends

codes segment
assume cs:codes,ds:data,ss:stacks                 ;对数据段、堆栈段、代码段进行声明
start:
      mov ax,data
      mov ds,ax
;-------------------------------------------------------------------------------
;根据要求编写代码开始 
      lea dx,str
      mov ah,9
      int 21h                                     ;显示提示字符串
    
      mov ah,10                                   ;输入字符串到缓冲区
      lea dx,str1                              
      int 21h                                  
    
      lea dx,crlf                                 ;回车换行
      mov ah,9
      int 21h                                  

      mov cl,str1n
      mov ch,0
      push cx
      lea si,str1s
      call sort                                  ;排序
       
      mov ah,2                                   ;显示输出，DL=输出字符
      mov dl,13                                  ;回车
      int 21h
      mov dl,10                                  ;换行
      int 21h
       
      pop cx
      mov dx,cx
      mov bx,16
      lea si,str1s
      mov ah,2


result1:   
      mov dl,[si]                                ;将排序结果加到字符串sortresult中
      mov  sortresult[bx],dl
      inc bx
      mov sortresult[bx],32

      inc si
      inc bx
      loop result1

      mov bx,27
      mov cx,dx
      lea si,str1s
      mov ah,2
      mov al,9

result2:   mov dl,[si]                           ;将数字结果加到numresult字符串中
      cmp dl,30h								
      js result3								                 ;和0的ASCII码作比较
      cmp dl,39h
      ja result3						                		 ;和9的ASCII码作比较

      mov numresult[bx],dl        
      mov dl,32
      inc bx
      inc si
      loop result2

result3:									                      ;不是数字则不加入字符串numresult中
      inc bx
      inc si
      loop result2

over:
     mov dx,offset sortresult
     mov ah,9
     int 21h
     mov dx,offset numresult
     mov ah,9
     int 21h


      mov ah,4ch
      int 21h
       
;********************************************
; 单个字符串内部的排序（冒泡排序）
sort  proc near
      push ax                                    ; 串长度置入cx，串首地址置入 si
      push cx
      push dx
      push si
      push di
      pushf
      push cx
      pop dx
      dec dx
sort1:
      mov cx,dx
      mov di,si
sort2:
      mov al,[di+1]
      cmp al,[di]
      jnb sortnext
      xchg al,[di]
      mov [di+1],al
sortnext:
      inc di
      loop sort2
      dec dx
      jnz sort1
      popf
      pop di
      pop si
      pop dx
      pop cx
      pop ax
      ret
sort  endp

;根据要求编写代码结束
;-------------------------------------------------------------------------
codes ends
    end start


                                           ;20161724_代欣月_实验4