;编写一程序，要求比较两个字符串STRING1和STRING2所含字符是否相同，
;若相同则显示‘MATCH’,若不相同则显示‘N。字符串的内容在程序中指定。

data segment                         ;定义数据段
string1   db 'cqu'
string2   db 'cuq'
equal     db 'MATCH',0dh,0ah,'$'
nequal    db 'N',0dh,0ah,'$'
data ends

stack segment stack                  ;定义堆栈段
db 200 dup (0)
stack ends

code segment
assume cs:code,ds:data,ss:stack      ;对数据段、堆栈段、代码段进行声明
start:push ds
      sub ax,ax
      push ax
      mov ax,data 
      mov ds,ax                      ;让ds寄存器指向data段
      mov ax,stack
      mov ss,ax                      ;让ss寄存器指向stack段
;--------------------------------------------------------------
;根据要求编写代码开始 
      mov es,ax
      lea si ,string1
      lea di ,string2
      mov cx,string2-string1
      rep cmpsb                      ;将string1和string2的内容进行比较
      jne sno                        
      mov ah,09h
      lea dx,equal
      int 21h
      jmp over

sno:  mov ah,09h
      lea dx,nequal
      int 21h
      pop ds
 
over: pop ax
      pop ds
;根据要求编写代码结束
;-------------------------------------------------------------

      mov ax,4ch
      int 21h

code ends
     end start
