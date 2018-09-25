

;1.	定义10个字节的键盘缓冲区，然后键盘输入字符填满该缓冲区，做如下工作：
;分别将输入键盘缓冲区的字符按数字，小写字母，大写字母，其他字符进行计数；
;分别将这些计数值显示出来。



data segment                                ;定义数据段
str   db 'Please input a string:$'          ;串结束符$
buf   db 11
      db ?
      db 11 dup(?)
crlf  db 0ah,0dh,'$'
count db "The number of integer letters:"   
      db  1 dup(?)                          ;数字个数
      db  "  The number of lowercase letters:"
      db  1 dup(?)                          ;小写子母个数
      db   "  The number of uppercase letters:"
      db  1 dup(?)                          ;大写子母个数
      db  "  The number of other letters:"
      db  1 dup(?)                          ;其它字符的个数
      db  '$'

 intercounts   db  '0'                      ;数字个数并初始化为0
 lowercasecounts   db  '0'                  ;小写字符个数并初始化为0
 uppercasecounts    db   '0'                ;大写字符个数并初始化为0
 othercounts   db   '0'                     ;其它字符个数并初始化为0

data ends

stack segment                               ;定义堆栈段
       db 200 dup(?)
stack ends

codes segment
assume cs:codes,ds:data,ss:stack          ;对数据段、堆栈段、代码段进行声明
start:
      push ds
      sub ax,ax
      push ax
      mov ax,data 
      mov ds,ax                             ;让ds寄存器指向data段
      mov ax,stack
      mov ss,ax                             ;让ss寄存器指向stack段
;--------------------------------------------------------------
;根据要求编写代码开始 
    
     lea dx,str
     mov ah,9
     int 21h                                ;显示提示字符串

     mov ah,10                              ;输入字符串到缓冲区
     lea dx,buf                               
     int 21h                                  
    
     lea dx,crlf                            ;回车换行
     mov ah,9
     int 21h                              

     mov bx,-1              
     mov cx,10                              ;缓冲区共十个字节需要检验 


loop1:
     add bx,1
     mov al,buf[bx+2]
     mov ah,0
     
     cmp ax,30h                   
     jz loopnum
     js loopoth                            ;和0的ASCII码作比较
     cmp ax,39h
     jz loopnum
     js loopnum                            ;和9的ASCII码作比较

     cmp ax,41h                  
     jz loopcap
     js loopoth                            ;和A的ASCII码作比较
     cmp ax,5ah
     jz loopcap
     js loopcap                            ;和Z的ASCII码作比较

     cmp ax,61h
     jz looplow
     js loopoth                            ;和a的ASCII码作比较
     cmp ax,7ah
     jz looplow
     js looplow                            ;和z的ASCII码作比较

     jmp loopoth
loopnum:
     add intercounts,1
     loop loop1
     jmp addcount
looplow:                                   ;给小写子母个数加1
     add  lowercasecounts,1
     loop loop1
     jmp addcount
loopcap:                                   ;给大写子母个数加一
     add  uppercasecounts,1
     loop  loop1
     jmp addcount
loopoth:                                   ;给其他字符加一
     add  othercounts,1
     loop  loop1
     jmp addcount


addcount:                                   ;将数都加到字符串count
     mov  al,intercounts
     mov  count[30],al
     mov  al,lowercasecounts
     mov  count[65],al
     mov  al,uppercasecounts
     mov  count[100],al
     mov  al,othercounts
     mov  count[131],al
     

over:
     mov dx,offset count
     mov ah,9
     int 21h
;根据要求编写代码结束
;-------------------------------------------------------------
     mov ah,4ch
     int 21h
codes ends
    end start